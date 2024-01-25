import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';
import 'package:poke_fusion/features/splash/domain/repository/poke_data_repository.dart';
import 'package:poke_fusion/features/splash/domain/usecases/poke_data_usecase.dart'; // Importe a biblioteca Mocktail

// Crie uma classe mock para o PokeDataRepository
class MockPokeDataRepository extends Mock implements PokeDataRepository {}

void main() {
  group('PokeDataUseCaseImp', () {
    late PokeDataUseCaseImp pokeDataUseCase;
    late MockPokeDataRepository mockRepository;

    setUp(() {
      // Configurar o ambiente de teste
      mockRepository = MockPokeDataRepository();
      pokeDataUseCase = PokeDataUseCaseImp(repository: mockRepository);
    });

    List<PokeDataEntity> success = [
      PokeDataEntity(
        name: faker.animal.name(),
      ),
      PokeDataEntity(
        name: faker.animal.name(),
      ),
    ];

    test('should return a Response Success when repository is called',
        () async {
      // Arrange
      when(() => mockRepository.call())
          .thenAnswer((_) async => Response.success(success));

      // Act
      final result = await pokeDataUseCase.call();

      expect(result.isSuccess, true);
      expect(result.asSuccess, success);

      // Assert
      verify(() => mockRepository.call()).called(1);
    });

    test('should return a error when something wrong happens', () async {
      final tResponseFailure = ResponseGenericError(error: Exception());

      // Arrange
      when(() => mockRepository.call()).thenAnswer(
        (i) async => Response.fail(tResponseFailure),
      );

      // Act
      final result = await pokeDataUseCase.call();

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.asFailure, tResponseFailure);

      verify(() => mockRepository.call()).called(1);
    });
  });
}
