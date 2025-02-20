import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/configuration/app_flavor.dart';
import 'di/app_module.dart';
import 'features/launch/presentation/bloc/launch_bloc.dart';
import 'features/launch/presentation/pages/launch_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.enableRegisteringMultipleInstancesOfOneType();

  final flavor = FlavorConfig();
  await flavor.getFlavorSettings();
  await flavor.loadEnv();

  await AppModule().provideModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => appModule<LaunchBloc>()..add(LoadLaunches()))],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const LaunchPage(),
      ),
    );
  }
}
