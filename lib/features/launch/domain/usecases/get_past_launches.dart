import '../../data/models/launch_query_request.dart';
import '../entities/launch.dart';
import '../repositories/launch_repository.dart';

class GetPastLaunches {
  final LaunchRepository repository;

  GetPastLaunches(this.repository);

  Future<List<Launch>> call(LaunchQueryRequest request) async {
    return await repository.getPastLaunches(request);
  }
}
