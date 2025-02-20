import 'package:dio/dio.dart';
import '../models/launch_model.dart';

class LaunchRemoteDataSource {
  final Dio dio;

  LaunchRemoteDataSource(this.dio);

  Future<List<LaunchModel>> getPastLaunches() async {
    final response = await dio.get('/launches/past');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json) => LaunchModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
