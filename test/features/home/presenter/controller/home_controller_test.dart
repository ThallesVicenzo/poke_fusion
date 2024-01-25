import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/domain/usecases/fusion_usecase.dart';
import 'package:poke_fusion/features/home/presenter/controller/home_controller.dart';

class MockFusionUseCase extends Mock implements FusionUseCase {}

void main() {
  group('HomeController', () {
    late HomeController sut;
    late MockFusionUseCase mockFusionUseCase;

    setUp(() {
      mockFusionUseCase = MockFusionUseCase();
      sut = HomeController(useCase: mockFusionUseCase);
    });

    String headPokemon = faker.animal.name();
    String bodyPokemon = faker.animal.name();

    test('get fusion success', () async {
      final fusionEntity = FusionEntity(
        name: faker.animal.name(),
        image: faker.image.image(),
      );

      when(() => mockFusionUseCase.call(any(), any()))
          .thenAnswer((_) async => Response.success(fusionEntity));

      await sut.getFusion(headPokemon: headPokemon, bodyPokemon: bodyPokemon);

      expect(sut.state.value.isSuccess, true);
      expect(sut.state.value.asSuccess, equals(fusionEntity));

      verify(() => mockFusionUseCase.call(headPokemon, bodyPokemon)).called(1);
    });

    test('get fusion fail', () async {
      final error = ResponseGenericError(
        error: 'Error',
        errorCode: 500,
      );

      when(() => mockFusionUseCase.call(any(), any()))
          .thenAnswer((_) async => Response.fail(error));

      await sut.getFusion(headPokemon: headPokemon, bodyPokemon: bodyPokemon);

      expect(sut.state.value.isError, true);
      expect(sut.state.value.asError, equals(error));
    });
  });
}
