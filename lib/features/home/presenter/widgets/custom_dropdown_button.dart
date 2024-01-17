import 'package:flutter/material.dart';

import '../../../splash/domain/entities/poke_data_entity.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.name,
    required this.pokeData,
    required this.onChanged,
  });

  final String? name;
  final List<PokeDataEntity> pokeData;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text(
        'Select a pokemon',
      ),
      items: pokeData.map((e) {
        return DropdownMenuItem(
          value: e.name,
          child: Text(
            e.name,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: name,
    );
  }
}
