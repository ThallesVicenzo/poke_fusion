import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';

class PokeDataModel extends PokeDataEntity {
  PokeDataModel(
      {required super.name, required super.image, required super.entryNumber});

  factory PokeDataModel.fromJson(Map<String, dynamic> json) {
    return PokeDataModel(
      name: json['pokemon_species']['name'],
      image: json['pokemon_species']['url'],
      entryNumber: json['entry_number'],
    );
  }
}
