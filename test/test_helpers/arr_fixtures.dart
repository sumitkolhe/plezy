import 'package:harbor/models/arr/server_transfer.dart';
import 'package:harbor/services/arr/server_activity_service.dart';

/// A [ServerActivityService] that reports no transfers, for tests about
/// something other than polling.
class IdleServerActivityService implements ServerActivityService {
  @override
  Future<({List<ServerTransfer> transfers, List<String> unreachable})> fetch() async =>
      (transfers: const <ServerTransfer>[], unreachable: const <String>[]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
