import '../../domain/entities/poke_data_entity.dart';

abstract class PokeDataDataSource {
  Future<List<PokeDataEntity>> call();
}
