#!/usr/bin/env python3
"""Guard the architecture matrices and release contract in build.yml."""

from pathlib import Path
import re
import sys

from workflow_yaml import iter_uses_references, job_block


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_WORKFLOW = ROOT / ".github/workflows/build.yml"
FLUTTER_VERSION = "3.44.0"
FLUTTER_COMMIT = "559ffa3f75e7402d65a8def9c28389a9b2e6fe42"
if len(sys.argv) > 2:
    raise SystemExit(f"Usage: {Path(sys.argv[0]).name} [workflow-path]")
WORKFLOW = Path(sys.argv[1]).resolve() if len(sys.argv) == 2 else DEFAULT_WORKFLOW
# The shared bootstrap both windows-arm jobs call, and the pins it must keep.
# Resolved beside the workflow rather than from ROOT so that checking a fixture
# tree exercises this rule instead of silently re-reading the real action.
SETUP_FLUTTER_GIT = WORKFLOW.parents[1] / "actions/setup-flutter-git/action.yml"
text = WORKFLOW.read_text(encoding="utf-8")
errors: list[str] = []


def require(condition: bool, message: str) -> None:
    if not condition:
        errors.append(message)


def job(name: str) -> str:
    block = job_block(text, name)
    require(bool(block), f"missing {name} job")
    return block


def named_step(block: str, name: str) -> str:
    match = re.search(
        rf"(?ms)^      - name: {re.escape(name)}\n.*?(?=^      - |\Z)",
        block,
    )
    require(match is not None, f"missing '{name}' step")
    return match.group(0) if match else ""


def require_explicit_shells(name: str, block: str, shell: str) -> None:
    steps = re.findall(r"(?ms)^      - .*?(?=^      - |\Z)", block)
    run_steps = [step for step in steps if re.search(r"(?m)^        run:", step)]
    require(bool(run_steps), f"{name} must contain run steps")
    for step in run_steps:
        step_name = re.search(r"(?m)^      - name: (.+)$", step)
        label = step_name.group(1) if step_name else "unnamed step"
        require(
            f"        shell: {shell}\n" in step,
            f"{name} step '{label}' must explicitly use {shell}",
        )


for legacy_job in (
    "build-windows-x64",
    "build-windows-arm64",
    "build-linux-x64",
    "build-linux-arm64",
    "build-windows",
    "package-windows",
    "build-linux",
    "build-macos",
):
    require(f"  {legacy_job}:\n" not in text, f"legacy job {legacy_job} must stay removed")

release = job("create-release")
require(
    "needs: [validate-trusted-ref, build-android, build-ios]" in release,
    "release dependencies must include the trust gate and every platform build",
)
for artifact in (
    "android-apk",
    "ios-ipa",
):
    require(f"name: {artifact}" in release, f"release download lost {artifact}")

release_if = re.search(r"(?m)^    if: (.+)$", release)
require(release_if is not None, "release job must have an explicit condition")
release_condition = release_if.group(1) if release_if else ""
for build_input in (
    "build_android",
    "build_ios",
):
    require(
        f"&& inputs.{build_input}" in release_condition,
        f"release publication must require {build_input}",
    )

require("draft: true" in release, "build output must remain a draft release")
require("tag_name:" not in release, "build output must not bind a release tag")
require(
    "generate_release_notes:" not in release,
    "untagged draft releases must not request generated release notes",
)
require(
    "Refuse to overwrite a published release" not in release,
    "untagged draft creation must not inspect or block on published releases",
)

trusted_ref = job("validate-trusted-ref")
require("permissions: {}" in trusted_ref, "trusted-ref validation must have no token permissions")
require(
    '"$GITHUB_REF" != "refs/heads/main"' in trusted_ref,
    "trusted-ref validation must reject non-main refs",
)
for protected_job in (
    "build-android",
    "build-ios",
):
    require(
        "needs: validate-trusted-ref" in job(protected_job),
        f"{protected_job} must depend on trusted-ref validation",
    )

require(
    text.count(FLUTTER_VERSION) == 1 and f'FLUTTER_VERSION: "{FLUTTER_VERSION}"' in text,
    "the Flutter SDK version must be written once, as the workflow FLUTTER_VERSION env",
)
require(
    "TRUSTED_BUILD_CACHE_VERSION: trusted-build-v1" in text,
    "build caches must use a dedicated trusted namespace",
)
require("restore-keys:" not in text, "privileged build caches must not use prefix fallback")
cache_keys = re.findall(r"(?m)^          key: (.+)$", text)
require(bool(cache_keys), "build workflow must define cache keys")
for cache_key in cache_keys:
    require(
        "TRUSTED_BUILD_CACHE_VERSION" in cache_key,
        f"cache key is outside the trusted build namespace: {cache_key}",
    )
require(
    text.count("cache-key:") == text.count("cache: true"),
    "every Flutter SDK cache must define its trusted cache key",
)

# check_workflow_action_pins.py owns the SHA-pin rule for every workflow, this
# one included; build.yml only adds the credential invariant on top, because it
# is workflow_dispatch-only and so escapes the pull-request rule in
# check_workflow_security.py.
remote_actions = [
    reference.rpartition("@")[0]
    for _, reference in iter_uses_references(text)
    if not reference.startswith("./")
]
require(bool(remote_actions), "build workflow must use pinned actions")
require(
    text.count("persist-credentials: false") == remote_actions.count("actions/checkout"),
    "every build checkout must discard GitHub credentials",
)

if errors:
    for error in errors:
        print(f"ERROR: {error}", file=sys.stderr)
    sys.exit(1)

print("build workflow architecture matrix checks passed")
