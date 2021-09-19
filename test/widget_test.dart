import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockMainRepository extends Mock implements MainRepository {}

void main() {

  group('ChartBloc test', () {

    MockMainRepository mockMainRepository;
    ChartBloc chartBloc;

    setUp(() {
      mockMainRepository = MockMainRepository();
      chartBloc = ChartBloc(repository: mockMainRepository);
    });


    final chartHasData = ChartResult(price: 66.1, changePercent: 5.55,
        changeAmount: 1434.9, high: 66.7, low: 55.6, volumePrimary24h: 234,
        volumeSecondary24h: 2342.52, holdingsPrimary: 55.55,
        holdingsSecondary: 55.08, points: [342.0, 4242.0],
        pointsStartFrom: DateTime.now(), errorMessage: null, fieldName: null,
        isSuccessful: true
    );

    const chartHasNoData = ChartResult(price: null, changePercent: null,
        changeAmount: null, high: null, low: null, volumePrimary24h: null,
        volumeSecondary24h: null, holdingsPrimary: null,
        holdingsSecondary: null, points: [], pointsStartFrom: null,
        errorMessage: null, fieldName: null, isSuccessful: true
    );

    const chartError = ChartResult(price: null, changePercent: null,
        changeAmount: null, high: null, low: null, volumePrimary24h: null,
        volumeSecondary24h: null, holdingsPrimary: null,
        holdingsSecondary: null, points: [], pointsStartFrom: null,
        errorMessage: "SERVER ERROR", fieldName: "SERVER ERROR",
        isSuccessful: false
    );


    test('emits [ChartLoading, ChartHasData] when successful', () {

        when(mockMainRepository.getMarketChart('1d', 'Xbt', 'Aud'))
            .thenAnswer((_) async => chartHasData);

        final bloc = ChartBloc(repository: mockMainRepository);

        bloc.add(GetChart('1d', 'Xbt', 'Aud'));

        expectLater(
          bloc,
          emitsInOrder([
            ChartLoading(),
            ChartHasData(chartHasData),
          ]),
        );

      });

    test('emits [ChartLoading, ChartNoData] when successful', () {

        when(mockMainRepository.getMarketChart('1d', 'Xbt', 'Aud'))
            .thenAnswer((_) async => chartHasNoData);

        final bloc = ChartBloc(repository: mockMainRepository);

        bloc.add(GetChart('1d', 'Xbt', 'Aud'));

        expectLater(
          bloc,
          emitsInOrder([
            ChartLoading(),
            const ChartNoData('ChartNoData'),
          ]),
        );

      });

    test('emits [ChartLoading, ChartError] when successful', () {

      when(mockMainRepository.getMarketChart('1d', 'Xbt', 'Aud'))
          .thenAnswer((_) async => chartError);

      final bloc = ChartBloc(repository: mockMainRepository);

      bloc.add(GetChart('1d', 'Xbt', 'Aud'));

      expectLater(
        bloc,
        emitsInOrder([
          ChartLoading(),
          const ChartError('SERVER ERROR'),
        ]),
      );

    });

  });

}
