import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:harbor/connection/connection.dart';
import 'package:harbor/media/ids.dart';
import 'package:harbor/services/jellyfin_client.dart';

JellyfinConnection testJellyfinConnection({
  String machineId = 'srv-1',
  String userId = 'user-1',
  String? id,
  String baseUrl = 'https://jf.example.com',
  List<String>? baseUrls,
  String serverName = 'Home',
  String userName = 'User',
  String accessToken = 'token',
  String deviceId = 'device-1',
  bool isAdministrator = false,
  ConnectionStatus status = ConnectionStatus.unknown,
  DateTime? createdAt,
  DateTime? lastAuthenticatedAt,
}) {
  return JellyfinConnection(
    id: id ?? '$machineId/$userId',
    baseUrl: baseUrl,
    baseUrls: baseUrls,
    serverName: serverName,
    serverMachineId: machineId,
    userId: userId,
    userName: userName,
    accessToken: accessToken,
    deviceId: deviceId,
    isAdministrator: isAdministrator,
    status: status,
    createdAt: createdAt ?? DateTime.utc(2024),
    lastAuthenticatedAt: lastAuthenticatedAt,
  );
}

JellyfinClient testJellyfinClient({
  JellyfinConnection? connection,
  http.Client? httpClient,
  Future<http.Response> Function(http.Request request)? handler,
  void Function()? onAllEndpointsExhausted,
}) {
  assert(httpClient == null || handler == null, 'Provide either httpClient or handler, not both');
  return JellyfinClient.forTesting(
    connection: connection ?? testJellyfinConnection(),
    httpClient: httpClient ?? MockClient(handler ?? _defaultResponse),
    onAllEndpointsExhausted: onAllEndpointsExhausted,
  );
}

/// A client bound to an explicit server id.
///
/// Mirrors the shape the old Plex fixture offered so tests that only needed
/// "a client registered for this server" keep reading the same way.
JellyfinClient testClientForServer(
  ServerId serverId, {
  Future<http.Response> Function(http.Request request)? handler,
  bool isAdministrator = false,
}) => testJellyfinClient(
  connection: testJellyfinConnection(machineId: serverId.toString(), isAdministrator: isAdministrator),
  handler: handler,
);

Future<http.Response> _defaultResponse(http.Request request) async {
  return http.Response('{}', 200, headers: const {'content-type': 'application/json'});
}
