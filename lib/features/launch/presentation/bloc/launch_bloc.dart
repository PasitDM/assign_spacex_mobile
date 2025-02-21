import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final launches = await getPastLaunches();
        emit(LaunchLoaded(launches: launches, originalLaunches: launches, sortType: SortType.missionNameAsc));
      } catch (e) {
        emit(LaunchError(e.toString()));
      }
    });

    on<SortLaunches>((event, emit) async {
      if (state is LaunchLoaded) {
        final currentState = state as LaunchLoaded;
        var sortedLaunches = List<Launch>.from(currentState.originalLaunches);

        switch (event.sortType) {
          case SortType.missionNameAsc:
            sortedLaunches.sort((a, b) => a.name.compareTo(b.name));
            break;
          case SortType.missionNameDesc:
            sortedLaunches.sort((a, b) => b.name.compareTo(a.name));
            break;
          case SortType.launchDateAsc:
            sortedLaunches.sort((a, b) => a.dateUtc.compareTo(b.dateUtc));
            break;
          case SortType.launchDateDesc:
            sortedLaunches.sort((a, b) => b.dateUtc.compareTo(a.dateUtc));
            break;
        }

        emit(LaunchLoaded(launches: sortedLaunches, originalLaunches: currentState.originalLaunches, sortType: event.sortType));
      }
    });

    on<SearchLaunches>((event, emit) async {
      if (state is LaunchLoaded) {
        final currentState = state as LaunchLoaded;
        var filteredLaunches =
            currentState.originalLaunches
                .where((launch) => launch.name.toLowerCase().contains(event.query.toLowerCase()))
                .toList();

        // Apply the current sort type to the filtered launches
        switch (currentState.sortType) {
          case SortType.missionNameAsc:
            filteredLaunches.sort((a, b) => a.name.compareTo(b.name));
            break;
          case SortType.missionNameDesc:
            filteredLaunches.sort((a, b) => b.name.compareTo(a.name));
            break;
          case SortType.launchDateAsc:
            filteredLaunches.sort((a, b) => a.dateUtc.compareTo(b.dateUtc));
            break;
          case SortType.launchDateDesc:
            filteredLaunches.sort((a, b) => b.dateUtc.compareTo(a.dateUtc));
            break;
        }

        emit(
          LaunchLoaded(
            launches: filteredLaunches,
            originalLaunches: currentState.originalLaunches,
            sortType: currentState.sortType,
          ),
        );
      }
    });
  }
}
