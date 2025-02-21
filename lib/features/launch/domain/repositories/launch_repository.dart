import '../entities/launch.dart';
import '../entities/launchpad.dart';
import '../entities/rocket.dart';

abstract class LaunchRepository {
  Future<List<Launch>> getPastLaunches({int limit, int page, String sortField, String sortOrder, String query});
  Future<Rocket> getRocketById(String rocketId);
  Future<Launchpad> getLaunchpadById(String launchpadId);
}
