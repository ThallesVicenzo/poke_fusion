import 'package:poke_fusion/core/client/client_http_exception.dart';
import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';

import '../../domain/entities/poke_data_entity.dart';
import '../../domain/repository/poke_data_repository.dart';
import '../data_source/pokedata_data_source.dart';

class PokeDataRepositoryImp implements PokeDataRepository {
  final PokeDataDataSource dataSource;

  PokeDataRepositoryImp({
    required this.dataSource,
  });

  @override
  Future<Response<ResponseError, List<PokeDataEntity>>> call() async {
    try {
      final pokeData = await dataSource.call();
      return Success(pokeData);
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
