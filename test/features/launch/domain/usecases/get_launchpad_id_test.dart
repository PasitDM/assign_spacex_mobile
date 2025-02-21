import 'package:assign_spacex_mobile/features/launch/domain/entities/launchpad.dart';
import 'package:assign_spacex_mobile/features/launch/domain/repositories/launch_repository.dart';
import 'package:assign_spacex_mobile/features/launch/domain/usecases/get_launchpad_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLaunchRepository extends Mock implements LaunchRepository {}

void main() {
  group('GetLaunchpadId UseCase', () {
    late GetLaunchpadId usecase;
    late MockLaunchRepository mockLaunchRepository;

    setUp(() {
      mockLaunchRepository = MockLaunchRepository();
      usecase = GetLaunchpadId(mockLaunchRepository);
    });

    test('should get launchpad by id from the repository', () async {
      // Arrange
      const launchpadId = '5e9e4502f5090995de566f86';
      final launchpad = Launchpad(
        name: "Kwajalein Atoll",
        fullName: "Kwajalein Atoll Omelek Island",
        details: "SpaceX original launch site, where all of the Falcon 1 launches occurred (2006-2009).",
      );
      when(mockLaunchRepository.getLaunchpadById(launchpadId)).thenAnswer((_) async => launchpad);

      // Act
      final result = await usecase(launchpadId);

      // Assert
      expect(result, launchpad);
      verify(mockLaunchRepository.getLaunchpadById(launchpadId));
      verifyNoMoreInteractions(mockLaunchRepository);
    });
  });
}
