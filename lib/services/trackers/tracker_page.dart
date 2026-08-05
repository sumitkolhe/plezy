import 'package:http/http.dart' as http;

/// One page of a paginated tracker response, parsed from the `X-Pagination-*`
/// headers, as Trakt does. A service that paginates in its body needs its own
/// shape instead.
class TrackerPage<T> {
  final List<T> items;
  final int page;
  final int pageCount;
  final int? itemCount;

  const TrackerPage({required this.items, required this.page, required this.pageCount, required this.itemCount});

  bool get hasMore => page < pageCount;

  /// Endpoints where pagination is optional omit the headers; default to a
  /// single page so callers never loop.
  factory TrackerPage.fromResponse(http.Response res, List<T> items) => TrackerPage(
    items: items,
    page: int.tryParse(res.headers['x-pagination-page'] ?? '') ?? 1,
    pageCount: int.tryParse(res.headers['x-pagination-page-count'] ?? '') ?? 1,
    itemCount: int.tryParse(res.headers['x-pagination-item-count'] ?? ''),
  );
}
