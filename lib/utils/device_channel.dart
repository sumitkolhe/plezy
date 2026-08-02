import 'package:flutter/services.dart';

/// Native device bridge (TV detection, device name, performance signals,
/// process-exit diagnostics). Implemented per platform under `co.sumit.harbor/device`.
const MethodChannel deviceChannel = MethodChannel('co.sumit.harbor/device');
