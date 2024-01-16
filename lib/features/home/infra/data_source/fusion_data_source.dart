import '../../domain/entities/fusion_entity.dart';

abstract class FusionDataSource {
  Future<FusionEntity> call(String head, String body);
}
