import 'package:assign_spacex_mobile/features/launch/data/models/launch_query_request.dart';
import 'package:assign_spacex_mobile/features/launch/domain/entities/launch.dart';
import 'package:assign_spacex_mobile/features/launch/domain/repositories/launch_repository.dart';
import 'package:assign_spacex_mobile/features/launch/domain/usecases/get_query_launches.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLaunchRepository extends Mock implements LaunchRepository {}

void main() {
  group('GetQueryLaunches UseCase', () {
    late GetQueryLaunches usecase;
    late MockLaunchRepository mockLaunchRepository;

    setUp(() {
      mockLaunchRepository = MockLaunchRepository();
      usecase = GetQueryLaunches(mockLaunchRepository);
    });

    test('should get past launches from the repository with given request', () async {
      // Arrange
      final request = LaunchQueryRequest(limit: 10, page: 1, sortField: 'name', sortOrder: 'asc', query: '');
      final launches = [
        Launch(
          name: "FalconSat",
          dateUtc: "2006-03-24T22:30:00.000Z",
          details: "Engine failure at 33 seconds and loss of vehicle",
          patchSmall: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
          patchLarge: "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
          upcoming: false,
          success: false,
          rocket: "5e9d0d95eda69955f709d1eb",
          crew: [],
          launchpad: "5e9e4502f5090995de566f86",
        ),
      ];
      when(mockLaunchRepository.getQueryLaunches(request)).thenAnswer((_) async => launches);

      // Act
      final result = await usecase(request);

      // Assert
      expect(result, launches);
      verify(mockLaunchRepository.getQueryLaunches(request));
      verifyNoMoreInteractions(mockLaunchRepository);
    });

    test('should return an empty list when no launches are found', () async {
      // Arrange
      final request = LaunchQueryRequest(limit: 10, page: 1, sortField: 'name', sortOrder: 'asc', query: '');
      final launches = <Launch>[];
      when(mockLaunchRepository.getQueryLaunches(request)).thenAnswer((_) async => launches);

      // Act
      final result = await usecase(request);

      // Assert
      expect(result, launches);
      verify(mockLaunchRepository.getQueryLaunches(request));
      verifyNoMoreInteractions(mockLaunchRepository);
    });
  });
}
