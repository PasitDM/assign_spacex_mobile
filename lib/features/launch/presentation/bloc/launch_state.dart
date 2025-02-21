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

  const LaunchLoaded({required this.launches, required this.originalLaunches, required this.sortType});

  @override
  List<Object> get props => [launches, originalLaunches, sortType];
}

class LaunchError extends LaunchState {
  final String message;

  const LaunchError(this.message);

  @override
  List<Object> get props => [message];
}
