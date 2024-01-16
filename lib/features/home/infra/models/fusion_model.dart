import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';

class FusionModel extends FusionEntity {
  FusionModel({required super.name, required super.image});

  factory FusionModel.fromJson(Map<String, dynamic> json) {
    return FusionModel(
      name: json['name'],
      image: json['image_url'],
    );
  }
}
