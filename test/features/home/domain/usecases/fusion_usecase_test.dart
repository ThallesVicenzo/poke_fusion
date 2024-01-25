import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/domain/repository/fusion_repository.dart';
import 'package:poke_fusion/features/home/domain/usecases/fusion_usecase.dart';

class MockFusionRepository extends Mock implements FusionRepository {}

void main() {
  group('FusionUseCase', () {
    late FusionUsecaseImp sut;
    late MockFusionRepository mockFusionRepository;

    setUp(() {
      mockFusionRepository = MockFusionRepository();
      sut = FusionUsecaseImp(repository: mockFusionRepository);
    });

    String head = faker.animal.name();
    String body = faker.image.image();

    test('Should return a Success when method call is called', () async {
      final success = FusionEntity(
        name: faker.animal.name(),
        image: faker.image.image(),
      );

      when(() => mockFusionRepository.call(any(), any())).thenAnswer(
        (_) async => Response.success(success),
      );

      final result = await sut.call(head, body);

      expect(result.isSuccess, true);
      expect(result.asSuccess, success);
    });

    test('Should return a error when something wrong happens', () async {
      final tResponseFailure = ResponseGenericError(error: Exception());

      when(() => mockFusionRepository.call(any(), any())).thenAnswer(
        (_) async => Response.fail(tResponseFailure),
      );

      final result = await sut.call(head, body);

      expect(result.isFailure, true);
      expect(result.asFailure, tResponseFailure);
    });
  });
}
