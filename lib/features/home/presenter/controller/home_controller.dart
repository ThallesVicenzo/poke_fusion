import 'package:flutter/material.dart';
import 'package:poke_fusion/core/page_state.dart';

import '../../domain/entities/poke_data_entity.dart';
import '../../domain/usecases/poke_data_usecase.dart';

class HomeController extends ChangeNotifier {
  final PokeDataUseCase useCase;

  HomeController({required this.useCase});

  final state = ValueNotifier<PageState<List<PokeDataEntity>>>(InitialState());

  double opacity = 1;

  Future<void> getPokeData() async {
    state.value = LoadingState();
    final result = await useCase.call();

    result.deal(
      onFail: (e) => state.value = ErrorState(error: e),
      onSuccess: (s) {
        state.value = SuccessState(data: s);
        print(state.value);
      },
    );
    notifyListeners();
  }
}
