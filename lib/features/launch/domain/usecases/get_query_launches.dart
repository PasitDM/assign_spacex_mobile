import '../../data/models/launch_query_request.dart';
import '../entities/launch.dart';
import '../repositories/launch_repository.dart';

class GetQueryLaunches {
  final LaunchRepository repository;

  GetQueryLaunches(this.repository);

  Future<List<Launch>> call(LaunchQueryRequest request) async {
    return await repository.getQueryLaunches(request);
  }
}
