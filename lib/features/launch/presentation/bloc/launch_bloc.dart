import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/launch_query_request.dart';
import '../../domain/entities/launch.dart';
import '../../domain/usecases/get_past_launches.dart';

part 'launch_event.dart';
part 'launch_state.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  final GetPastLaunches getPastLaunches;

  LaunchBloc(this.getPastLaunches) : super(LaunchInitial()) {
    on<InitialLaunches>((event, emit) async {
      emit(LaunchLoading());
      try {
        final request = LaunchQueryRequest();
        final launches = await getPastLaunches(request);
        emit(LaunchLoaded(launches: launches, originalLaunches: launches, sortType: SortType.missionNameAsc));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });

    on<SortLaunches>((event, emit) async {
      emit(LaunchLoading());
      try {
        final request = LaunchQueryRequest(sortField: event.sortType.field, sortOrder: event.sortType.order);
        final launches = await getPastLaunches(request);
        emit(LaunchLoaded(launches: launches, originalLaunches: launches, sortType: event.sortType));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });

    on<SearchLaunches>((event, emit) async {
      emit(LaunchLoading());
      try {
        final request = LaunchQueryRequest(query: event.query);
        final launches = await getPastLaunches(request);
        emit(LaunchLoaded(launches: launches, originalLaunches: launches, sortType: SortType.missionNameAsc));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });

    on<LoadMoreLaunches>((event, emit) async {
      if (state is LaunchLoaded) {
        final currentState = state as LaunchLoaded;
        try {
          final request = LaunchQueryRequest(page: event.page);
          final launches = await getPastLaunches(request);
          emit(
            LaunchLoaded(
              launches: currentState.launches + launches,
              originalLaunches: currentState.originalLaunches + launches,
              sortType: currentState.sortType,
            ),
          );
        } catch (e) {
          emit(LaunchError(e.toString()));
        }
      }
    });
  }
}
