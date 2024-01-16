import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';

abstract class FusionRepository {
  Future<Response<ResponseError, FusionEntity>> call(String head, String body);
}
