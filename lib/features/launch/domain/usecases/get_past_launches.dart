import '../entities/launch.dart';
import '../repositories/launch_repository.dart';

class GetPastLaunches {
  final LaunchRepository repository;

  GetPastLaunches(this.repository);

  Future<List<Launch>> call() async {
    return await repository.getPastLaunches();
  }
}
