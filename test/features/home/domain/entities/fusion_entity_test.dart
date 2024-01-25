import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';

void main() {
  group('fusion entity', () {
    test('Should create fusion entity with the correct values', () {
      String name = faker.animal.name();
      String image = faker.internet.httpsUrl();

      final fusionEntity = FusionEntity(name: name, image: image);

      expect(fusionEntity.name, equals(name));
      expect(fusionEntity.image, equals(image));
    });
  });
}
