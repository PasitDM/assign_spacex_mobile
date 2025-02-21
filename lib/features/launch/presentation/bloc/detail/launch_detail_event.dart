part of 'launch_detail_bloc.dart';

abstract class LaunchDetailEvent extends Equatable {
  const LaunchDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchLaunchDetail extends LaunchDetailEvent {
  final String rocketId;
  final String launchpadId;

  const FetchLaunchDetail({required this.rocketId, required this.launchpadId});

  @override
  List<Object> get props => [rocketId, launchpadId];
}
