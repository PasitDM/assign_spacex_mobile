class LaunchModel {
  final String name;
  final String dateUtc;
  final bool upcoming;
  final bool success;
  final String? details;
  final String? patchSmall;
  final String? patchLarge;
  final String? webcast;
  final String? rocket;
  final List<String>? crew;
  final String? launchpad;

  LaunchModel({
    required this.name,
    required this.dateUtc,
    required this.upcoming,
    required this.success,
    this.details,
    this.patchSmall,
    this.patchLarge,
    this.webcast,
    this.rocket,
    this.crew,
    this.launchpad,
  });

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      name: json['name'],
      dateUtc: json['date_utc'],
      upcoming: json['upcoming'],
      success: json['success'] ?? false,
      details: json['details'],
      patchSmall: json['links']['patch']['small'],
      patchLarge: json['links']['patch']['large'],
      webcast: json['links']['webcast'],
      rocket: json['rocket'],
      crew: (json['crew'] as List<dynamic>?)?.map((e) => e as String).toList(),
      launchpad: json['launchpad'],
    );
  }

  @override
  String toString() {
    return 'LaunchModel(name: $name, dateUtc: $dateUtc, upcoming: $upcoming, success: $success, details: $details, patchSmall: $patchSmall, patchLarge: $patchLarge, webcast: $webcast, rocket: $rocket, crew: $crew, launchpad: $launchpad)';
  }
}
