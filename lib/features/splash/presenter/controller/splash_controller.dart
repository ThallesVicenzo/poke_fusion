import 'package:flutter/material.dart';
import 'package:poke_fusion/core/page_state.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';
import 'package:poke_fusion/features/splash/domain/usecases/poke_data_usecase.dart';

class SplashController extends ChangeNotifier {
  final PokeDataUseCase useCase;

  SplashController({required this.useCase});

  final state = ValueNotifier<PageState<List<PokeDataEntity>>>(InitialState());

  Future<void> getPokeData() async {
    state.value = LoadingState();
    final result = await useCase.call();

    return result.deal(
      onFail: (e) => state.value = ErrorState(error: e),
      onSuccess: (s) {
        state.value = SuccessState(data: s);
      },
    );
  }
}
