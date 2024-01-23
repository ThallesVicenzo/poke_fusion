import 'package:flutter_modular/flutter_modular.dart';
import 'package:mocktail/mocktail.dart';

class MockModularNavigator extends Mock implements IModularNavigator {
  MockModularNavigator() {
    when(() => navigateHistory).thenReturn([]);
    registerFallbackValue("any");
    when(() => pushNamed(
          any(),
          arguments: any(named: "arguments"),
          forRoot: any(named: "forRoot"),
        )).thenAnswer((_) async => null);
    when(() => pushReplacementNamed(
          any(),
          arguments: any(named: "arguments"),
        )).thenAnswer((_) async => Future.value());
    when(() => navigate(
          any(),
          arguments: any(named: "arguments"),
        )).thenAnswer((_) async {});
    when(() => pop()).thenAnswer((_) async {});
  }
}
