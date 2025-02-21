class LaunchQueryRequest {
  final int limit;
  final int page;
  final String sortField;
  final String sortOrder;
  final String query;

  LaunchQueryRequest({this.limit = 30, this.page = 1, this.sortField = 'name', this.sortOrder = 'asc', this.query = ''});
}
