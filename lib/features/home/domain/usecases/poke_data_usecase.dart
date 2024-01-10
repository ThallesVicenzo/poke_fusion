import 'package:poke_fusion/core/domain/response_error.dart';
import 'package:poke_fusion/core/response.dart';

import '../entities/poke_data_entity.dart';
import '../repository/poke_data_repository.dart';

abstract class PokeDataUseCase {
  Future<Response<ResponseError, List<PokeDataEntity>>> call();
}

class PokeDataUseCaseImp implements PokeDataUseCase {
  final PokeDataRepository repository;

  const PokeDataUseCaseImp({required this.repository});

  @override
  Future<Response<ResponseError, List<PokeDataEntity>>> call() async {
    return await repository.call();
  }
}
