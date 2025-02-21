import '../../data/models/launch_model.dart';

class Launch {
  final String name;
  final String dateUtc;
  final String details;
  final String patchSmall;
  final String patchLarge;
  final bool upcoming;
  final bool success;
  final String rocket;
  final List<Crew> crew;
  final String launchpad;

  Launch({
    required this.name,
    required this.dateUtc,
    required this.details,
    required this.patchSmall,
    required this.patchLarge,
    required this.upcoming,
    required this.success,
    required this.rocket,
    required this.crew,
    required this.launchpad,
  });
}
