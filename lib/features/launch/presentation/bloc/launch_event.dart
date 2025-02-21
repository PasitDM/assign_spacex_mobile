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

class LoadMoreLaunches extends LaunchEvent {
  final int page;

  const LoadMoreLaunches(this.page);

  @override
  List<Object> get props => [page];
}

enum SortType { missionNameAsc, missionNameDesc, launchDateAsc, launchDateDesc }

extension SortTypeExtension on SortType {
  String get field {
    switch (this) {
      case SortType.missionNameAsc:
      case SortType.missionNameDesc:
        return 'name';
      case SortType.launchDateAsc:
      case SortType.launchDateDesc:
        return 'date_utc';
    }
  }

  String get order {
    switch (this) {
      case SortType.missionNameAsc:
      case SortType.launchDateAsc:
        return 'asc';
      case SortType.missionNameDesc:
      case SortType.launchDateDesc:
        return 'desc';
    }
  }
}
