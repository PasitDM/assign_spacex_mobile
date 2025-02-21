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
  final List<Crew>? crew;
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
      crew: json['crew'] != null ? (json['crew'] as List).map((i) => Crew.fromJson(i)).toList() : null,
      launchpad: json['launchpad'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['date_utc'] = dateUtc;
    data['upcoming'] = upcoming;
    data['success'] = success;
    data['details'] = details;
    data['links'] = {
      'patch': {'small': patchSmall, 'large': patchLarge},
      'webcast': webcast,
    };
    data['rocket'] = rocket;
    if (crew != null) {
      data['crew'] = crew!.map((v) => v.toJson()).toList();
    }
    data['launchpad'] = launchpad;
    return data;
  }

  @override
  String toString() {
    return 'LaunchModel(name: $name, dateUtc: $dateUtc, upcoming: $upcoming, success: $success, details: $details, patchSmall: $patchSmall, patchLarge: $patchLarge, webcast: $webcast, rocket: $rocket, crew: $crew, launchpad: $launchpad)';
  }
}

class Crew {
  final String crew;
  final String role;

  Crew({required this.crew, required this.role});

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(crew: json['crew'], role: json['role']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['crew'] = crew;
    data['role'] = role;
    return data;
  }
}
