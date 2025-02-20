import '../../domain/entities/launch.dart';
import '../../domain/repositories/launch_repository.dart';
import '../datasources/launch_remote_data_source.dart';

class LaunchRepositoryImpl implements LaunchRepository {
  final LaunchRemoteDataSource remoteDataSource;

  LaunchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Launch>> getPastLaunches() async {
    final launchModels = await remoteDataSource.getPastLaunches();
    return launchModels
        .map(
          (model) => Launch(
            name: model.name,
            dateUtc: model.dateUtc,
            details: model.details ?? '',
            patchSmall: model.patchSmall ?? '',
            patchLarge: model.patchLarge ?? '',
            webcast: model.webcast ?? '',
          ),
        )
        .toList();
  }
}
