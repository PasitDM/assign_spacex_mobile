import 'package:assign_spacex_mobile/features/launch/data/models/launch_query_request.dart';
import 'package:assign_spacex_mobile/features/launch/domain/entities/launch.dart';
import 'package:assign_spacex_mobile/features/launch/domain/usecases/get_query_launches.dart';
import 'package:assign_spacex_mobile/features/launch/presentation/bloc/launch_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetQueryLaunches extends Mock implements GetQueryLaunches {}

void main() {
  group('LaunchBloc', () {
    late LaunchBloc bloc;
    late MockGetQueryLaunches mockGetQueryLaunches;

    setUp(() {
      mockGetQueryLaunches = MockGetQueryLaunches();
      bloc = LaunchBloc(mockGetQueryLaunches);
    });

    test('initial state should be LaunchInitial', () {
      expect(bloc.state, equals(LaunchInitial()));
    });

    blocTest<LaunchBloc, LaunchState>(
      'emits [LaunchLoading, LaunchLoaded] when InitialLaunches is added and getQueryLaunches succeeds',
      build: () {
        when(mockGetQueryLaunches(LaunchQueryRequest())).thenAnswer(
          (_) async => [
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
          ],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(InitialLaunches()),
      expect: () => [LaunchLoading(), isA<LaunchLoaded>()],
    );

    blocTest<LaunchBloc, LaunchState>(
      'emits [LaunchLoading, LaunchError] when InitialLaunches is added and getQueryLaunches fails',
      build: () {
        when(mockGetQueryLaunches(LaunchQueryRequest())).thenThrow(Exception('Failed to load launches'));
        return bloc;
      },
      act: (bloc) => bloc.add(InitialLaunches()),
      expect: () => [LaunchLoading(), isA<LaunchError>()],
    );
  });
}
