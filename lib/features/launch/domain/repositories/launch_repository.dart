import '../entities/launch.dart';

abstract class LaunchRepository {
  Future<List<Launch>> getPastLaunches();
}
