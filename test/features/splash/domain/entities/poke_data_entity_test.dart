import 'package:flutter_test/flutter_test.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';

void main() {
  group('PokeDataEntity', () {
    test('should create PokeDataEntity with the provided name', () {
      // Arrange
      const String testName = 'Pikachu';

      // Act
      const pokeDataEntity = PokeDataEntity(name: testName);

      // Assert
      expect(pokeDataEntity.name, equals(testName));
    });
  });
}
