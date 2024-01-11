import 'package:flutter_test/flutter_test.dart';
import 'package:poke_fusion/features/splash/infra/models/pokedata_model.dart';

void main() {
  test('should return a PokeDataModel when api request is called', () {
    // arrange
    final json = {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon-species/1/"
    };

    final pokeModel = PokeDataModel.fromJson(json);
    // assert

    expect(pokeModel, isA<PokeDataModel>());
  });
}
