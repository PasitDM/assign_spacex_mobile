part of 'launch_bloc.dart';

abstract class LaunchState extends Equatable {
  const LaunchState();

  @override
  List<Object> get props => [];
}

class LaunchInitial extends LaunchState {}

class LaunchLoading extends LaunchState {}

class LaunchLoaded extends LaunchState {
  final List<Launch> launches;
  final List<Launch> originalLaunches;
  final SortType sortType;
  final bool hasReachedMax;

  const LaunchLoaded({
    required this.launches,
    required this.originalLaunches,
    required this.sortType,
    this.hasReachedMax = false,
  });

  LaunchLoaded copyWith({List<Launch>? launches, List<Launch>? originalLaunches, SortType? sortType, bool? hasReachedMax}) {
    return LaunchLoaded(
      launches: launches ?? this.launches,
      originalLaunches: originalLaunches ?? this.originalLaunches,
      sortType: sortType ?? this.sortType,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [launches, originalLaunches, sortType, hasReachedMax];
}

class LaunchError extends LaunchState {
  final String message;

  const LaunchError(this.message);

  @override
  List<Object> get props => [message];
}
