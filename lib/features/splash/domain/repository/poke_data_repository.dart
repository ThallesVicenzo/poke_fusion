import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';

abstract class PokeDataRepository {
  Future<Response<ResponseError, List<PokeDataEntity>>> call();
}
