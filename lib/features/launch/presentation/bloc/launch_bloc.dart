import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/launch.dart';
import '../../domain/usecases/get_past_launches.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  final GetPastLaunches getPastLaunches;

  LaunchBloc(this.getPastLaunches) : super(LaunchInitial()) {
    on<LoadLaunches>((event, emit) async {
      emit(LaunchLoading());
      try {
        final launches = await getPastLaunches();
        emit(LaunchLoaded(launches));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });
  }
}
