import 'package:flutter_test/flutter_test.dart';
import 'package:poke_fusion/features/home/infra/models/fusion_model.dart';

void main() {
  test('should return a fusion model when api request is called', () {
    final json = {
      "name": "Charchu",
      "image_url": "https://images.alexonsager.net/pokemon/fused/25/25.6.png",
      "fused": {"head": "Charizard", "body": "Pikachu"}
    };

    final fusionModel = FusionModel.fromJson(json);

    expect(fusionModel, isA<FusionModel>());
  });
}
