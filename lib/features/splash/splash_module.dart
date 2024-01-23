import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/splash/presenter/page/splash_page.dart';
import 'package:poke_fusion/features/splash/splash_routes.dart';
import 'domain/repository/poke_data_repository.dart';
import 'domain/usecases/poke_data_usecase.dart';
import 'external/pokedata_data_source_imp.dart';
import 'infra/data_source/pokedata_data_source.dart';
import 'infra/repository/pokedata_repository_imp.dart';
import 'presenter/controller/splash_controller.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<PokeDataDataSource>(
          (i) => PokeDataDataSourceImpl(
            clientHttp: i(),
          ),
        ),
        Bind.factory<PokeDataRepository>(
          (i) => PokeDataRepositoryImp(
            dataSource: i<PokeDataDataSource>(),
          ),
        ),
        Bind.factory<PokeDataUseCase>(
          (i) => PokeDataUseCaseImp(
            repository: i<PokeDataRepository>(),
          ),
        ),
        Bind.factory(
          (i) => SplashController(
            useCase: i<PokeDataUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          SplashRoutes.splashPage.route,
          child: (context, _) => SplashPage(
            controller: context.read<SplashController>(),
          ),
        ),
      ];
}
