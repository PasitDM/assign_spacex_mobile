class LaunchModel {
  final String name;
  final String dateUtc;
  final String? details;
  final String? patchSmall;
  final String? patchLarge;
  final String? webcast;

  LaunchModel({required this.name, required this.dateUtc, this.details, this.patchSmall, this.patchLarge, this.webcast});

  factory LaunchModel.fromJson(Map<String, dynamic> json) {
    return LaunchModel(
      name: json['name'],
      dateUtc: json['date_utc'],
      details: json['details'],
      patchSmall: json['links']['patch']['small'],
      patchLarge: json['links']['patch']['large'],
      webcast: json['links']['webcast'],
    );
  }

  @override
  String toString() {
    return 'LaunchModel(name: $name, dateUtc: $dateUtc, details: $details, patchSmall: $patchSmall, patchLarge: $patchLarge, webcast: $webcast)';
  }
}
