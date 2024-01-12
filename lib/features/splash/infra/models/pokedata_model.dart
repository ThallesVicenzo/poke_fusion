import 'package:poke_fusion/core/map_extensions.dart';

import '../../domain/entities/poke_data_entity.dart';

class PokeDataModel extends PokeDataEntity {
  PokeDataModel({
    required super.name,
    required super.image,
  });

  factory PokeDataModel.fromJson(Map<String, dynamic> json) {
    return PokeDataModel(
      name: json.getValue('name'),
      image: json.getValue('url'),
    );
  }
}
