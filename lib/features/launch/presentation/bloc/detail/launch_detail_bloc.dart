import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/launchpad.dart';
import '../../../domain/entities/rocket.dart';
import '../../../domain/usecases/get_launchpad_id.dart';
import '../../../domain/usecases/get_rocket_id.dart';

part 'launch_detail_event.dart';
part 'launch_detail_state.dart';

class LaunchDetailBloc extends Bloc<LaunchDetailEvent, LaunchDetailState> {
  final GetRocketId getRocketId;
  final GetLaunchpadId getLaunchpadId;

  LaunchDetailBloc({required this.getRocketId, required this.getLaunchpadId}) : super(LaunchDetailInitial()) {
    on<FetchLaunchDetail>((event, emit) async {
      emit(LaunchDetailLoading());
      try {
        final rocket = await getRocketId(event.rocketId);
        final launchpad = await getLaunchpadId(event.launchpadId);
        emit(LaunchDetailLoaded(rocket: rocket, launchpad: launchpad));
      } catch (e) {
        emit(LaunchDetailError(e.toString()));
      }
    });
  }
}
