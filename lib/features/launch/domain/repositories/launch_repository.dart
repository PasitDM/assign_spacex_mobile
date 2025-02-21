import '../../data/models/launch_query_request.dart';
import '../entities/launch.dart';
import '../entities/launchpad.dart';
import '../entities/rocket.dart';

abstract class LaunchRepository {
  Future<List<Launch>> getQueryLaunches(LaunchQueryRequest request);
  Future<Rocket> getRocketById(String rocketId);
  Future<Launchpad> getLaunchpadById(String launchpadId);
}
