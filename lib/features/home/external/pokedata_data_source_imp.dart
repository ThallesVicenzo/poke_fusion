import 'package:dio/dio.dart';
import 'package:poke_fusion/features/home/domain/entities/poke_data_entity.dart';
import 'package:poke_fusion/features/home/infra/models/pokedata_model.dart';

import '../infra/data_source/pokedata_data_source.dart';

class PokeDataDataSourceImpl implements PokeDataDataSource {
  final Dio dio;

  PokeDataDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<PokeDataEntity>> call() async {
    final response = await dio.get(
        'https://keith.api.stdlib.com/pokefusion@0.2.0/?headPokemon=charizard&bodyPokemon=pikachu');
    print(response.data);

    final pokeData = response.data['pokemon_entries'] as List;

    return pokeData.map((e) => PokeDataModel.fromJson(e)).toList();
  }
}
