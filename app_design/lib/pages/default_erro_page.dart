import 'package:app_design/app_images.dart';
import 'package:app_design/widgets/asset_image_widget.dart';
import 'package:app_design/widgets/ui_overlay_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/default_button.dart';

class ErrorPageParams {
  /// Title of error page
  final String titleError;

  /// Message of error page (optional) default: 'Tente novamente mais tarde.'
  final String messageError;

  /// Error log only for debug mode (optional) default: null
  final String? errorlog;

  /// Button title of error page (optional) default: 'Voltar'
  final String buttonErrorTitle;

  /// Function to be called when button is pressed (optional) default: Navigator.of(context).pop()
  final void Function(BuildContext context)? onButtonPressed;

  /// Code of error page (optional) default: null
  final String? code;

  /// Image of error page (optional) default: AppImage.pikachuError
  final AppImage image;

  /// Call pop when button is pressed or back button is pressed (optional) default: true
  final bool autoPop;

  const ErrorPageParams({
    this.titleError = 'Algo deu errado',
    this.messageError = 'Tente novamente mais tarde.',
    this.buttonErrorTitle = 'Tentar Novamente',
    this.onButtonPressed,
    this.code,
    this.errorlog,
    this.image = AppImage.pikachuError,
    this.autoPop = true,
  });

  ErrorPageParams copyWith({
    String? titleError,
    String? messageError,
    String? errorlog,
    String? buttonErrorTitle,
    void Function(BuildContext context)? onButtonPressed,
    String? code,
    AppImage? icon,
  }) {
    return ErrorPageParams(
      titleError: titleError ?? this.titleError,
      messageError: messageError ?? this.messageError,
      buttonErrorTitle: buttonErrorTitle ?? this.buttonErrorTitle,
      onButtonPressed: onButtonPressed ?? this.onButtonPressed,
      code: code ?? this.code,
      image: icon ?? image,
      errorlog: errorlog ?? this.errorlog,
    );
  }

  @override
  String toString() {
    return 'ErrorPageParams(titleError: $titleError, '
        'messageError: $messageError, '
        'errorlog: $errorlog, '
        'buttonErrorTitle: $buttonErrorTitle, '
        'onButtonPressed: $onButtonPressed, '
        'code: $code, '
        'image: $image, '
        'autoPop: $autoPop)';
  }
}

class DefaultErrorPage extends StatelessWidget {
  final ErrorPageParams params;
  final void Function() onBackStart;
  const DefaultErrorPage({
    super.key,
    this.params = const ErrorPageParams(),
    required this.onBackStart,
  });

  @override
  Widget build(BuildContext context) {
    return UiOverlayColor(
      overlayColor: Colors.black87,
      brightness: Brightness.light,
      child: WillPopScope(
        onWillPop: () async {
          if (params.onButtonPressed == null) {
            Navigator.of(context).canPop()
                ? Navigator.of(context).pop()
                : Navigator.of(context).pushReplacementNamed('/');
          } else {
            params.onButtonPressed?.call(context);
          }
          return params.autoPop;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF161616),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetImageWidget(
                    image: params.image,
                    size: const Size(300, 300),
                  ),
                  const SizedBox(height: 72),
                  Visibility(
                    visible: kDebugMode,
                    child: GestureDetector(
                      onTap: () async {
                        final scaffoldMessger = ScaffoldMessenger.of(context);
                        await Clipboard.setData(
                          ClipboardData(
                            text: params.toString(),
                          ),
                        );
                        scaffoldMessger.showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Copiado para área de transferência',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    params.titleError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    params.messageError,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: params.code != null,
                    child: Text(
                      'Código: ${params.code}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: kDebugMode && params.errorlog != null,
                    child: Text(
                      params.errorlog ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultButton(
                  title: params.onButtonPressed == null
                      ? 'Voltar'
                      : params.buttonErrorTitle,
                  onPressed: () {
                    if (params.onButtonPressed == null) {
                      Navigator.of(context).canPop()
                          ? Navigator.of(context).pop()
                          : Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                    } else {
                      params.autoPop ? Navigator.of(context).pop() : null;
                      params.onButtonPressed?.call(context);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: onBackStart,
                    child: const Text(
                      'Fechar App',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
