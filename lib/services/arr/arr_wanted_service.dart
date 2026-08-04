import '../../models/arr/absent_title.dart';
import '../../models/arr/managed_service.dart';
import '../../providers/managed_services_provider.dart';
import '../../utils/app_logger.dart';

/// Films Radarr wants but has no file for.
///
/// Read from `/wanted/missing` rather than by filtering the whole library: a
/// large Radarr holds thousands of films, and only the gap is interesting.
class ArrWantedService {
  const ArrWantedService(this._services);

  final ManagedServicesProvider _services;

  static const int _pageSize = 60;

  Future<List<AbsentTitle>> absentMovies() async {
    final titles = <AbsentTitle>[];
    for (final connection in _services.of(ManagedServiceKind.radarr)) {
      final client = _services.arrClient(connection.id);
      if (client == null) continue;
      try {
        final data = await client.get('/wanted/missing', query: {'pageSize': '$_pageSize', 'sortKey': 'title'});
        final records = data is Map<String, dynamic> ? data['records'] : data;
        if (records is! List) continue;
        for (final record in records) {
          if (record is! Map<String, dynamic>) continue;
          final title = AbsentTitle.fromJson(record, sourceId: connection.id, sourceName: connection.displayName);
          if (title != null) titles.add(title);
        }
      } catch (e) {
        appLogger.d('${connection.kind.name}: wanted lookup failed', error: e);
      }
    }
    titles.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return titles;
  }
}
