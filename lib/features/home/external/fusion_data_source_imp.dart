import 'package:dio/dio.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/infra/models/fusion_model.dart';

import '../infra/data_source/fusion_data_source.dart';

class FusionDataSourceImp implements FusionDataSource {
  final Dio dio;

  FusionDataSourceImp({required this.dio});

  @override
  Future<FusionEntity> call(String head, String body) async {
    final response = await dio.get(
        'https://keith.api.stdlib.com/pokefusion@0.2.0/',
        queryParameters: {
          'headPokemon': head,
          'bodyPokemon': body,
        });

    return FusionModel.fromJson(response.data);
  }
}
