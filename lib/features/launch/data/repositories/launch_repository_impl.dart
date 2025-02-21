import '../../domain/entities/launch.dart';
import '../../domain/entities/launchpad.dart';
import '../../domain/entities/rocket.dart';
import '../../domain/repositories/launch_repository.dart';
import '../datasources/launch_remote_data_source.dart';
import '../models/launch_query_request.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource remoteDataSource;

  LaunchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Launch>> getPastLaunches(LaunchQueryRequest request) async {
    final launchModels = await remoteDataSource.queryLaunches(request);
    return launchModels
        .map(
          (model) => Launch(
            name: model.name,
            dateUtc: model.dateUtc,
            details: model.details ?? '',
            patchSmall: model.patchSmall ?? '',
            patchLarge: model.patchLarge ?? '',
            upcoming: model.upcoming,
            success: model.success,
            rocket: model.rocket ?? '',
            crew: model.crew ?? [],
            launchpad: model.launchpad ?? '',
          ),
        )
        .toList();
  }

  @override
  Future<Rocket> getRocketById(String rocketId) async {
    final rocketModel = await remoteDataSource.getRocketById(rocketId);
    return Rocket(name: rocketModel.name ?? '', type: rocketModel.type ?? '', description: rocketModel.description ?? '');
  }

  @override
  Future<Launchpad> getLaunchpadById(String launchpadId) async {
    final launchpadModel = await remoteDataSource.getLaunchpadById(launchpadId);
    return Launchpad(
      name: launchpadModel.name ?? '',
      fullName: launchpadModel.fullName ?? '',
      details: launchpadModel.details ?? '',
    );
  }
}
