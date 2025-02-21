part of 'launch_bloc.dart';

abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object> get props => [];
}

class InitialLaunches extends LaunchEvent {}

class SortLaunches extends LaunchEvent {
  final SortType sortType;

  const SortLaunches(this.sortType);

  @override
  List<Object> get props => [sortType];
}

class SearchLaunches extends LaunchEvent {
  final String query;

  const SearchLaunches(this.query);

  @override
  List<Object> get props => [query];
}

enum SortType { missionNameAsc, missionNameDesc, launchDateAsc, launchDateDesc }
