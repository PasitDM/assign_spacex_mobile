import '../entities/rocket.dart';
import '../repositories/launch_repository.dart';

class GetRocketId {
  final LaunchRepository repository;

  GetRocketId(this.repository);

  Future<Rocket> call(String rocketId) async {
    return await repository.getRocketById(rocketId);
  }
}
