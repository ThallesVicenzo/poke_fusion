import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/client/client_http_exception.dart';
import 'package:poke_fusion/core/client/client_http_response.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';
import 'package:poke_fusion/features/splash/infra/data_source/pokedata_data_source.dart';
import 'package:poke_fusion/features/splash/infra/repository/pokedata_repository_imp.dart';

class MockPokeDataDataSource extends Mock implements PokeDataDataSource {}

void main() {
  group('PokeDataRepositoryImp', () {
    late PokeDataRepositoryImp pokeDataRepository;
    late MockPokeDataDataSource mockDataSource;

    setUp(() {
      // Configurar o ambiente de teste
      mockDataSource = MockPokeDataDataSource();
      pokeDataRepository = PokeDataRepositoryImp(dataSource: mockDataSource);
    });

    test('should return Success response when data source is successful',
        () async {
      // Arrange
      final fakePokeData = [
        PokeDataEntity(
          name: faker.animal.name(),
        ),
      ];
      when(() => mockDataSource.call()).thenAnswer((_) async => fakePokeData);

      // Act
      final result = await pokeDataRepository();

      // Assert
      expect(result.isSuccess, true);
      expect(result.asSuccess, equals(fakePokeData));

      verify(() => mockDataSource.call()).called(1);
    });

    test('should throw ResponseClientError when ClientHttpException occurs',
        () async {
      // Arrange
      final fakeException = ClientHttpException(
        error: 'Response Client Error',
        statusCode: 400,
        response: ClientHttpResponse(
          statusCode: 400,
        ),
      );

      when(() => mockDataSource.call()).thenThrow(fakeException);

      final result = await pokeDataRepository();
      // Act & Assert
      expect(result.isFailure, true);
      expect(result.asFailure, isA<ResponseClientError>());

      verify(() => mockDataSource.call()).called(1);
    });

    test('should throw ResponseGenericError for other exceptions', () async {
      // Arrange
      final fakeException = Exception('Some generic exception');
      when(() => mockDataSource.call()).thenThrow(fakeException);

      final result = await pokeDataRepository();

      // Act & Assert
      expect(result.isFailure, true);
      expect(result.asFailure, isA<ResponseGenericError>());

      verify(() => mockDataSource.call()).called(1);
    });
  });
}
