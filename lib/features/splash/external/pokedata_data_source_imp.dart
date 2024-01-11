import 'package:dio/dio.dart';

import '../domain/entities/poke_data_entity.dart';
import '../infra/data_source/pokedata_data_source.dart';
import '../infra/models/pokedata_model.dart';

class PokeDataDataSourceImpl implements PokeDataDataSource {
  final Dio dio;

  PokeDataDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<PokeDataEntity>> call() async {
    final response = await dio.get('https://pokeapi.co/api/v2/generation/1/');

    final pokeData = response.data['pokemon_species'] as List;

    return pokeData.map((e) => PokeDataModel.fromJson(e)).toList();
  }
}
