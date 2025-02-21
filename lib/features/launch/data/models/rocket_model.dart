class RocketModel {
  final String? name;
  final String? type;
  final String? description;

  RocketModel({this.name, this.type, this.description});

  factory RocketModel.fromJson(Map<String, dynamic> json) {
    return RocketModel(name: json['name'], type: json['type'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type, 'description': description};
  }
}
