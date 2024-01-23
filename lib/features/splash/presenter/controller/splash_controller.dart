import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/core/main_routes.dart';
import 'package:poke_fusion/core/page_state.dart';

import '../../domain/entities/poke_data_entity.dart';
import '../../domain/usecases/poke_data_usecase.dart';

class SplashController extends ChangeNotifier {
  final PokeDataUseCase useCase;

  SplashController({required this.useCase});

  final state = ValueNotifier<PageState<List<PokeDataEntity>>>(InitialState());

  final opacity = ValueNotifier<double>(1);

  void onAnimationEd(double value) {
    if (value == 0) {
      Modular.to.navigate(
        MainRoutes.home.route,
        arguments: state.value.asSuccess,
      );
    }
  }

  Future<void> getPokeData() async {
    state.value = LoadingState();
    final result = await useCase.call();
    result.deal(
      onFail: (e) => state.value = ErrorState(error: e),
      onSuccess: (s) {
        opacity.value = 0;
        state.value = SuccessState(data: s);
      },
    );
  }
}
