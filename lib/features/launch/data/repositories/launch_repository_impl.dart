import '../../domain/entities/launch.dart';
import '../../domain/entities/launchpad.dart';
import '../../domain/entities/rocket.dart';
import '../../domain/repositories/launch_repository.dart';
import '../datasources/launch_remote_data_source.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource remoteDataSource;

  LaunchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Launch>> getPastLaunches({
    int limit = 30,
    int page = 1,
    String sortField = 'date_utc',
    String sortOrder = 'desc',
    String query = '',
  }) async {
    final launchModels = await remoteDataSource.queryLaunches(
      limit: limit,
      page: page,
      sortField: sortField,
      sortOrder: sortOrder,
      query: query,
    );
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
