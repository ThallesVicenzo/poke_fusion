import 'package:app_design/pages/default_erro_page.dart';
import 'package:app_design/widgets/default_button.dart';
import 'package:app_design/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/core/main_routes.dart';
import 'package:poke_fusion/core/page_state.dart';
import 'package:poke_fusion/features/splash/domain/entities/poke_data_entity.dart';

import '../controller/home_controller.dart';
import '../widgets/custom_dropdown_button.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  final List<PokeDataEntity> pokeData;

  const HomePage({
    super.key,
    required this.pokeData,
    required this.controller,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.controller.state.addListener(listenableErrorState);
    super.initState();
  }

  void listenableErrorState() {
    final state = widget.controller.state.value;

    if (state is ErrorState) {
      Modular.to.pushNamed(
        MainRoutes.defaultError.route,
        arguments: ErrorPageParams(
          errorlog: state.asError.message,
          code: state.asError.code.toString(),
          onButtonPressed: (_) {
            widget.controller.getFusion(
              headPokemon: leftName,
              bodyPokemon: rightName,
            );
          },
        ),
      );
    }
  }

  String? leftName;
  String? rightName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: widget.controller.state,
          builder: (context, state, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 100),
                    child: Center(
                      child: Text(
                        'Fuse your favorite pokemon!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state is! SuccessState ? false : true,
                    replacement: state is LoadingState
                        ? const Padding(
                            padding: EdgeInsets.all(82),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(82),
                            child: SizedBox.shrink(),
                          ),
                    child: NetworkImageWidget(
                      url: state is! SuccessState ? '' : state.asSuccess.image!,
                      size: const Size(200, 200),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropDownButton(
                        name: leftName,
                        pokeData: widget.pokeData,
                        onChanged: (value) {
                          setState(() {
                            leftName = value;
                          });
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final temp = leftName;
                            leftName = rightName;
                            rightName = temp;
                          });
                        },
                        icon: const Icon(
                          Icons.swap_horiz,
                        ),
                      ),
                      CustomDropDownButton(
                        name: rightName,
                        pokeData: widget.pokeData,
                        onChanged: (value) {
                          setState(() {
                            rightName = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  DefaultButton(
                    desable: leftName == null || rightName == null,
                    title: 'Fuse',
                    onPressed: () {
                      widget.controller.getFusion(
                        headPokemon: leftName,
                        bodyPokemon: rightName,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
