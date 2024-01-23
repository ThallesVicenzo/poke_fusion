import 'package:poke_fusion/core/client/client_http.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/infra/models/fusion_model.dart';

import '../infra/data_source/fusion_data_source.dart';

class FusionDataSourceImp implements FusionDataSource {
  final ClientHttp clientHttp;

  FusionDataSourceImp({required this.clientHttp});

  @override
  Future<FusionEntity> call(String head, String body) async {
    final response = await clientHttp.get(
        'https://keith.api.stdlib.com/pokefusion@0.2.0/',
        queryParameters: {
          'headPokemon': head,
          'bodyPokemon': body,
        });

    return FusionModel.fromJson(response.data);
  }
}
