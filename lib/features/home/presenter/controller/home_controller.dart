import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:poke_fusion/core/page_state.dart';
import 'package:poke_fusion/features/home/domain/entities/fusion_entity.dart';
import 'package:poke_fusion/features/home/domain/usecases/fusion_usecase.dart';

class HomeController extends ChangeNotifier {
  final FusionUseCase useCase;

  HomeController({required this.useCase});

  final state = ValueNotifier<PageState<FusionEntity>>(InitialState());

  String fixWrongPokemonName(String name) {
    if (name == 'mr-mime') {
      return 'mr. mime';
    } else if (name == 'nidoran-f') {
      return 'Nidoran ♀';
    } else if (name == 'nidoran-m') {
      return 'Nidoran ♂';
    }
    return name;
  }

  Future<void> getFusion({
    required headPokemon,
    required bodyPokemon,
  }) async {
    state.value = LoadingState();
    final result = await useCase.call(
      fixWrongPokemonName(headPokemon),
      fixWrongPokemonName(bodyPokemon),
    );

    result.deal(
      onFail: (e) => state.value = ErrorState(error: e),
      onSuccess: (s) => state.value = SuccessState(data: s),
    );
  }
}
