import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:poke_fusion/core/client/client_http.dart';
import 'package:poke_fusion/core/client/client_http_response.dart';
import 'package:poke_fusion/features/splash/external/pokedata_data_source_imp.dart';

class MockDio extends Mock implements ClientHttp {}

void main() {
  group('PokeDataDataSourceImpl', () {
    late PokeDataDataSourceImpl pokeDataDataSource;
    late MockDio mockClientHttp;

    setUp(() {
      mockClientHttp = MockDio();
      pokeDataDataSource = PokeDataDataSourceImpl(
        clientHttp: mockClientHttp,
      );
    });

    test('should return a PokeDataModel when request is made', () async {
      // Arrange
      final fakePokemonData = [
        {'name': faker.animal.name()},
        {'name': faker.animal.name()},
      ];

      final responseData = {'pokemon_species': fakePokemonData};

      when(() => mockClientHttp.get(any())).thenAnswer(
        (_) async => ClientHttpResponse(
          data: responseData,
        ),
      );

      // Act
      final result = await pokeDataDataSource();

      // Assert
      expect(result.length, equals(fakePokemonData.length));
      expect(result[0].name, equals(fakePokemonData[0]['name']));
      expect(result[1].name, equals(fakePokemonData[1]['name']));
    });
  });
}
