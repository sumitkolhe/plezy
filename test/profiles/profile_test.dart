import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/profiles/profile.dart';

void main() {
  group('Profile', () {
    test('local profile defaults', () {
      final p = Profile.local(id: 'local-1', displayName: 'Owner', createdAt: DateTime(2026, 1, 1));
      expect(p.kind, ProfileKind.local);
      expect(p.isPinProtected, isFalse);
      expect(p.pinHash, isNull);
    });

    test('local profile with PIN is pin-protected', () {
      final p = Profile.local(
        id: 'local-1',
        displayName: 'Kids',
        pinHash: computePinHash('1234'),
        createdAt: DateTime(2026, 1, 1),
      );
      expect(p.isPinProtected, isTrue);
    });

    test('local PIN hash is round-tripped via configJson', () {
      final p = Profile.local(
        id: 'local-1',
        displayName: 'Kids',
        pinHash: computePinHash('1234'),
        createdAt: DateTime(2026, 1, 1),
      );
      final json = p.toConfigJson();
      final restored = Profile.fromRow(
        id: p.id,
        kind: 'local',
        displayName: p.displayName,
        avatarThumbUrl: null,
        json: json,
        sortOrder: 0,
        createdAt: p.createdAt,
        lastUsedAt: null,
      );
      expect(restored.pinHash, p.pinHash);
      expect(restored.isPinProtected, isTrue);
    });
  });

  group('PIN hashing', () {
    test('computePinHash is deterministic for the same input', () {
      expect(computePinHash('1234'), computePinHash('1234'));
    });

    test('computePinHash differs for different inputs', () {
      expect(computePinHash('1234'), isNot(computePinHash('5678')));
    });

    test('verifyPin matches its hash', () {
      final h = computePinHash('4242');
      expect(verifyPin('4242', h), isTrue);
      expect(verifyPin('1111', h), isFalse);
    });
  });
}
