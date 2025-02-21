class LaunchpadModel {
  final String? name;
  final String? fullName;
  final String? details;

  LaunchpadModel({this.name, this.fullName, this.details});

  factory LaunchpadModel.fromJson(Map<String, dynamic> json) {
    return LaunchpadModel(name: json['name'], fullName: json['full_name'], details: json['details']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'full_name': fullName, 'details': details};
  }
}
