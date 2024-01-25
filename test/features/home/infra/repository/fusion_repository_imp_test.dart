import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_fusion/core/client/client_http_exception.dart';
import 'package:poke_fusion/core/client/client_http_response.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/infra/data_source/fusion_data_source.dart';
import 'package:poke_fusion/features/home/infra/repository/fusion_repository_imp.dart';

class MockFusionDataSource extends Mock implements FusionDataSource {}

void main() {
  late FusionRepositoryImp sut;
  late MockFusionDataSource mockFusionDataSource;

  setUp(() {
    mockFusionDataSource = MockFusionDataSource();
    sut = FusionRepositoryImp(dataSource: mockFusionDataSource);
  });

  String head = faker.animal.name();

  String body = faker.animal.name();

  test('Should return Success when request is made', () async {
    final success = FusionEntity(
      name: faker.animal.name(),
      image: faker.image.image(),
    );

    when(() => mockFusionDataSource.call(any(), any())).thenAnswer(
      (_) async => success,
    );

    final result = await sut.call(head, body);

    expect(result.isSuccess, true);
    expect(result.asSuccess, equals(success));

    verify(() => mockFusionDataSource.call(head, body)).called(1);
  });

  test('Should return ResponseClientError when ClientHttpException occurs',
      () async {
    final fakeException = ClientHttpException(
      error: 'ResponseClientError',
      statusCode: 400,
      response: ClientHttpResponse(statusCode: 400),
    );

    when(() => mockFusionDataSource.call(any(), any()))
        .thenThrow(fakeException);

    final result = await sut.call(head, body);

    expect(result.isFailure, true);
    expect(result.asFailure, isA<ResponseClientError>());

    verify(() => mockFusionDataSource.call(head, body)).called(1);
  });

  test('should throw ResponseGenericError for other exceptions', () async {
    final fakeException = Exception('Generic Exception');

    when(() => mockFusionDataSource.call(any(), any()))
        .thenThrow(fakeException);

    final result = await sut.call(head, body);

    expect(result.isFailure, true);
    expect(result.asFailure, isA<ResponseGenericError>());

    verify(() => mockFusionDataSource.call(head, body)).called(1);
  });
}
