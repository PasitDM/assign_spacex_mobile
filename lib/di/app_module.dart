import 'package:get_it/get_it.dart';

import '../core/api/api_service.dart';
import '../features/launch/data/datasources/launch_remote_data_source.dart';
import '../features/launch/data/datasources/mock_launch_remote_data_source.dart';
import '../features/launch/data/repositories/launch_repository_impl.dart';
import '../features/launch/domain/repositories/launch_repository.dart';
import '../features/launch/domain/usecases/get_launchpad_id.dart';
import '../features/launch/domain/usecases/get_query_launches.dart';
import '../features/launch/domain/usecases/get_rocket_id.dart';
import '../features/launch/presentation/bloc/detail/launch_detail_bloc.dart';
import '../features/launch/presentation/bloc/launch_bloc.dart';

var appModule = GetIt.instance;

class AppModule {
  Future<void> provideModule() async {
    final dio = await ApiService().initial();
    appModule.registerLazySingleton(() => dio);

    // Data sources
    appModule.registerLazySingleton(() => LaunchRemoteDataSource(appModule.get()));
    appModule.registerLazySingleton(() => MockLaunchRemoteDataSource());

    // Repository
    appModule.registerLazySingleton<LaunchRepository>(
      () => LaunchRepositoryImpl(remoteDataSource: appModule.get(), mockDataSource: appModule.get()),
    );

    // Use cases
    appModule.registerLazySingleton(() => GetQueryLaunches(appModule.get()));
    appModule.registerLazySingleton(() => GetRocketId(appModule.get()));
    appModule.registerLazySingleton(() => GetLaunchpadId(appModule.get()));

    // BLoC
    appModule.registerFactory(() => LaunchBloc(appModule.get()));
    appModule.registerFactory(() => LaunchDetailBloc(getRocketId: appModule.get(), getLaunchpadId: appModule.get()));
  }
}
