import '../entities/launch.dart';
import '../repositories/launch_repository.dart';

class GetPastLaunches {
  final LaunchRepository repository;

  GetPastLaunches(this.repository);

  Future<List<Launch>> call({
    int limit = 30,
    int page = 1,
    String sortField = 'name',
    String sortOrder = 'asc',
    String query = '',
  }) async {
    return await repository.getPastLaunches(limit: limit, page: page, sortField: sortField, sortOrder: sortOrder, query: query);
  }
}
