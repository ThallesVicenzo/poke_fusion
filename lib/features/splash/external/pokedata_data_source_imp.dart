import 'package:poke_fusion/core/client/client_http.dart';

import '../domain/entities/poke_data_entity.dart';
import '../infra/data_source/pokedata_data_source.dart';
import '../infra/models/pokedata_model.dart';

class PokeDataDataSourceImpl implements PokeDataDataSource {
  final ClientHttp clientHttp;

  PokeDataDataSourceImpl({
    required this.clientHttp,
  });

  @override
  Future<List<PokeDataEntity>> call() async {
    final response =
        await clientHttp.get('https://pokeapi.co/api/v2/generation/1/');

    final pokeData = response.data['pokemon_species'] as List;

    return pokeData.map((e) => PokeDataModel.fromJson(e)).toList();
  }
}
