import 'package:dio/dio.dart';
import '../models/launch_model.dart';
import '../models/launch_query_request.dart';
import '../models/launchpad_model.dart';
import '../models/rocket_model.dart';

class LaunchRemoteDataSource {
  final Dio dio;

  LaunchRemoteDataSource(this.dio);

  Future<List<LaunchModel>> getQueryLaunches(LaunchQueryRequest request) async {
    final response = await dio.post(
      '/launches/query',
      data: {
        'query':
            request.query.isNotEmpty
                ? {
                  'name': {'\$regex': request.query, '\$options': 'i'},
                }
                : {},
        'options': {
          'limit': request.limit,
          'page': request.page,
          'sort': {request.sortField: request.sortOrder},
        },
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data['docs'];
      return jsonList.map((json) => LaunchModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load launches');
    }
  }

  Future<RocketModel> getRocketById(String rocketId) async {
    final response = await dio.get('/rockets/$rocketId');

    if (response.statusCode == 200) {
      return RocketModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load rocket details');
    }
  }

  Future<LaunchpadModel> getLaunchpadById(String launchpadId) async {
    final response = await dio.get('/launchpads/$launchpadId');

    if (response.statusCode == 200) {
      return LaunchpadModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load launchpad details');
    }
  }
}
