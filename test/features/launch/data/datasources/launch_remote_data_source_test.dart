import 'dart:convert';

import 'package:assign_spacex_mobile/features/launch/data/datasources/launch_remote_data_source.dart';
import 'package:assign_spacex_mobile/features/launch/data/models/launch_model.dart';
import 'package:assign_spacex_mobile/features/launch/data/models/launch_query_request.dart';
import 'package:assign_spacex_mobile/features/launch/data/models/launchpad_model.dart';
import 'package:assign_spacex_mobile/features/launch/data/models/rocket_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'launch_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LaunchRemoteDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = LaunchRemoteDataSource(mockDio);
  });

  group('LaunchRemoteDataSource', () {
    test('should return list of LaunchModel when the call to API is successful', () async {
      // Arrange
      final request = LaunchQueryRequest(limit: 10, page: 1, sortField: 'name', sortOrder: 'asc', query: '');
      final responsePayload = json.decode(
        await rootBundle.loadString('test/features/launch/data/datasources/mock_launch_data.json'),
      );
      when(
        mockDio.post(any, data: anyNamed('data')),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200, data: responsePayload));

      // Act
      final result = await dataSource.getQueryLaunches(request);

      // Assert
      expect(result, isA<List<LaunchModel>>());
      expect(result.length, 10);
      verify(mockDio.post(any, data: anyNamed('data')));
    });

    test('should return RocketModel when the call to API is successful', () async {
      // Arrange
      const rocketId = '5e9d0d95eda69955f709d1eb';
      final responsePayload = {
        "name": "Falcon 1",
        "type": "rocket",
        "description":
            "The Falcon 1 was an expendable launch system privately developed and manufactured by SpaceX during 2006-2009.",
      };
      when(
        mockDio.get(any),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200, data: responsePayload));

      // Act
      final result = await dataSource.getRocketById(rocketId);

      // Assert
      expect(result, isA<RocketModel>());
      expect(result.name, "Falcon 1");
      verify(mockDio.get(any));
    });

    test('should return LaunchpadModel when the call to API is successful', () async {
      // Arrange
      const launchpadId = '5e9e4502f5090995de566f86';
      final responsePayload = {
        "name": "Kwajalein Atoll",
        "full_name": "Kwajalein Atoll Omelek Island",
        "details": "SpaceX original launch site, where all of the Falcon 1 launches occurred (2006-2009).",
      };
      when(
        mockDio.get(any),
      ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200, data: responsePayload));

      // Act
      final result = await dataSource.getLaunchpadById(launchpadId);

      // Assert
      expect(result, isA<LaunchpadModel>());
      expect(result.name, "Kwajalein Atoll");
      verify(mockDio.get(any));
    });
  });
}
