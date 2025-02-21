import '../entities/launchpad.dart';
import '../repositories/launch_repository.dart';

class GetLaunchpadId {
  final LaunchRepository repository;

  GetLaunchpadId(this.repository);

  Future<Launchpad> call(String launchpadId) async {
    return await repository.getLaunchpadById(launchpadId);
  }
}