import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';
import 'package:poke_fusion/features/splash/domain/usecases/poke_data_usecase.dart';
import 'package:poke_fusion/features/splash/presenter/controller/splash_controller.dart';

class MockPokeDataUseCase extends Mock implements PokeDataUseCase {}

void main() {
  group('Splash Controller', () {
    late SplashController sut;
    late MockPokeDataUseCase mockPokeDataUseCase;

    setUp(() {
      mockPokeDataUseCase = MockPokeDataUseCase();
      sut = SplashController(useCase: mockPokeDataUseCase);
    });

    group('get poke data', () {
      test('should handle fail correctly', () async {
        final error = ResponseGenericError(
          error: 'Error',
          errorCode: 500,
        );

        when(() => mockPokeDataUseCase.call()).thenAnswer(
          (_) async => Response.fail(error),
        );

        await sut.getPokeData();

        expect(sut.state.value.isError, true);

        expect(
          sut.state.value.asError,
          equals(error),
        );

        verify(() => mockPokeDataUseCase.call()).called(1);
      });

      test('Should handle success correctly', () async {
        final fakeList = [
          PokeDataEntity(name: faker.animal.name()),
          PokeDataEntity(name: faker.animal.name()),
          PokeDataEntity(name: faker.animal.name()),
        ];

        when(() => mockPokeDataUseCase.call()).thenAnswer(
          (_) async => Response.success(fakeList),
        );

        await sut.getPokeData();

        expect(sut.state.value.isSuccess, true);

        expect(sut.opacity.value, equals(0));

        expect(
          sut.state.value.asSuccess,
          equals(fakeList),
        );

        verify(() => mockPokeDataUseCase.call()).called(1);
      });
    });
  });
}
