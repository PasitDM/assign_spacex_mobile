import 'package:get_it/get_it.dart';

import '../core/api/api_service.dart';
import '../features/launch/data/datasources/launch_remote_data_source.dart';
import '../features/launch/data/repositories/launch_repository_impl.dart';
import '../features/launch/domain/repositories/launch_repository.dart';
import '../features/launch/domain/usecases/get_past_launches.dart';
import '../features/launch/presentation/bloc/launch_bloc.dart';

var appModule = GetIt.instance;

class AppModule {
  Future<void> provideModule() async {
    final dio = await ApiService().initial();
    appModule.registerLazySingleton(() => dio);

    // Data sources
    appModule.registerLazySingleton(() => LaunchRemoteDataSource(appModule()));

    // Repository
    appModule.registerLazySingleton<LaunchRepository>(() => LaunchRepositoryImpl(remoteDataSource: appModule()));

    // Use cases
    appModule.registerLazySingleton(() => GetPastLaunches(appModule()));

    // BLoC
    appModule.registerFactory(() => LaunchBloc(appModule()));
  }
}
