import 'package:dio/dio.dart';
import '../models/launch_model.dart';
import '../models/launchpad_model.dart';
import '../models/rocket_model.dart';

class LaunchRemoteDataSource {
  final Dio dio;

  LaunchRemoteDataSource(this.dio);

  Future<List<LaunchModel>> queryLaunches({
    int limit = 30,
    int page = 1,
    String sortField = 'date_utc',
    String sortOrder = 'desc',
    String query = '',
  }) async {
    final response = await dio.post(
      '/launches/query',
      data: {
        'query':
            query.isNotEmpty
                ? {
                  'name': {'\$regex': query, '\$options': 'i'},
                }
                : {},
        'options': {
          'limit': limit,
          'page': page,
          'sort': {sortField: sortOrder},
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
