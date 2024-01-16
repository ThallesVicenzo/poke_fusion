import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';
import 'package:poke_fusion/features/home/domain/repository/fusion_repository.dart';

import '../entities/fusion_entity.dart';

abstract class FusionUseCase {
  Future<Response<ResponseError, FusionEntity>> call(String head, String body);
}

class FusionUsecaseImp implements FusionUseCase {
  final FusionRepository repository;

  FusionUsecaseImp({required this.repository});

  @override
  Future<Response<ResponseError, FusionEntity>> call(
      String head, String body) async {
    return await repository.call(head, body);
  }
}
