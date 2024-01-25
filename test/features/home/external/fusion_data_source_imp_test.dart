import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/client/client_http.dart';
import 'package:poke_fusion/core/client/client_http_response.dart';
import 'package:poke_fusion/features/home/external/fusion_data_source_imp.dart';
import 'package:poke_fusion/features/home/infra/models/fusion_model.dart';

class MockDio extends Mock implements ClientHttp {}

void main() {
  group('FusionDataSourceImp', () {
    late FusionDataSourceImp sut;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      sut = FusionDataSourceImp(clientHttp: mockDio);
    });

    String head = faker.animal.name();
    String body = faker.animal.name();

    test('Should return a Fusion Model when is a correct request', () async {
      final responseData = {
        'name': 'PikaCruel',
        'image_url': faker.image.image(),
      };

      when(() => mockDio.get(
            any(),
            queryParameters: {
              'headPokemon': head,
              'bodyPokemon': body,
            },
          )).thenAnswer((_) async => ClientHttpResponse(data: responseData));

      final response = await sut.call(head, body);

      expect(response, isA<FusionModel>());
    });
  });
}
