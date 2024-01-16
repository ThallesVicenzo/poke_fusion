import 'package:poke_fusion/core/client/client_http_exception.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/domain/repository/fusion_repository.dart';
import 'package:poke_fusion/features/home/infra/data_source/fusion_data_source.dart';

class FusionRepositoryImp implements FusionRepository {
  final FusionDataSource dataSource;

  FusionRepositoryImp({required this.dataSource});

  @override
  Future<Response<ResponseError, FusionEntity>> call(
      String head, String body) async {
    try {
      final fusionData = await dataSource.call(head, body);
      return Success(fusionData);
    } on ClientHttpException catch (e) {
      throw Response.fail(
        ResponseClientError(
          exception: e,
          errorCode: e.responseCode,
          errorMessage: e.responseMessage,
        ),
      );
    } catch (e) {
      return Response.fail(
        ResponseGenericError(error: e),
      );
    }
  }
}
