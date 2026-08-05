import '../../models/arr/absent_title.dart';
import '../../models/arr/managed_service.dart';
import '../../providers/managed_services_provider.dart';
import '../../utils/app_logger.dart';

/// What an *arr wants and has no file for.
///
/// Read from `/wanted/missing` rather than by filtering the whole library: a
/// large instance holds thousands of records, and only the gap is interesting.
class ArrWantedService {
  const ArrWantedService(this._services);

  final ManagedServicesProvider _services;

  static const int _pageSize = 60;

  /// Films Radarr wants but has no file for.
  Future<List<AbsentTitle>?> absentMovies() => _missing(
    ManagedServiceKind.radarr,
    query: {'pageSize': '$_pageSize', 'sortKey': 'title'},
    parse: AbsentTitle.fromJson,
    order: (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
  );

  /// Episodes Sonarr wants but has no file for. `includeSeries` is what carries
  /// the series name and poster; the episode record alone has neither.
  Future<List<AbsentTitle>?> absentEpisodes() => _missing(
    ManagedServiceKind.sonarr,
    query: {'pageSize': '$_pageSize', 'sortKey': 'airDateUtc', 'sortDirection': 'descending', 'includeSeries': 'true'},
    parse: AbsentTitle.fromEpisodeJson,
    // Most recently aired first: the gap you noticed last is the one you want.
    order: (a, b) => (b.airDate ?? DateTime(0)).compareTo(a.airDate ?? DateTime(0)),
  );

  /// Null when an instance of [kind] is configured but none of them answered — a
  /// caller that cached the empty list instead would hide the view until the app
  /// restarted, on nothing worse than one timed-out request.
  ///
  /// An empty list means the question was asked and the answer was "none".
  Future<List<AbsentTitle>?> _missing(
    ManagedServiceKind kind, {
    required Map<String, String> query,
    required AbsentTitle? Function(Map<String, dynamic>, {required String sourceId, required String sourceName}) parse,
    required Comparator<AbsentTitle> order,
  }) async {
    final titles = <AbsentTitle>[];
    final instances = _services.of(kind);
    var answered = 0;
    for (final connection in instances) {
      final client = _services.arrClient(connection.id);
      if (client == null) continue;
      try {
        final data = await client.get('/wanted/missing', query: query);
        final records = data is Map<String, dynamic> ? data['records'] : data;
        answered++;
        if (records is! List) continue;
        for (final record in records) {
          if (record is! Map<String, dynamic>) continue;
          final title = parse(record, sourceId: connection.id, sourceName: connection.displayName);
          if (title != null) titles.add(title);
        }
      } catch (e) {
        // Warning, not debug: this failure hides a whole view, and release
        // builds log at info, so a debug line made it invisible exactly when it
        // mattered.
        appLogger.w('${connection.displayName}: wanted lookup failed', error: e);
      }
    }
    if (instances.isNotEmpty && answered == 0) {
      appLogger.w('No ${kind.name} answered the wanted lookup; leaving it unresolved to retry');
      return null;
    }
    // Each instance answers already sorted, but two of them concatenate into
    // something that is not.
    titles.sort(order);
    appLogger.i('${kind.name} wanted: ${titles.length} absent from $answered instance(s)');
    return titles;
  }
}
