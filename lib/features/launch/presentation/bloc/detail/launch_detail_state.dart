part of 'launch_detail_bloc.dart';

abstract class LaunchDetailState extends Equatable {
  const LaunchDetailState();

  @override
  List<Object> get props => [];
}

class LaunchDetailInitial extends LaunchDetailState {}

class LaunchDetailLoading extends LaunchDetailState {}

class LaunchDetailLoaded extends LaunchDetailState {
  final Rocket rocket;
  final Launchpad launchpad;

  const LaunchDetailLoaded({required this.rocket, required this.launchpad});

  @override
  List<Object> get props => [rocket, launchpad];
}

class LaunchDetailError extends LaunchDetailState {
  final String message;

  const LaunchDetailError(this.message);

  @override
  List<Object> get props => [message];
}
