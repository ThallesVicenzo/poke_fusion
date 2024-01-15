import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  ValueNotifier<String> selectedPokemon = ValueNotifier('select a pokémon');
  String? image;

  void updateSelectedPokemon(
      String? selectedPokemonName, String? selectedPokemonImage) {
    selectedPokemon.value = selectedPokemonName!;
    notifyListeners();
  }
}
