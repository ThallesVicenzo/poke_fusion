import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repository/poke_data_repository.dart';
import 'domain/usecases/poke_data_usecase.dart';
import 'external/pokedata_data_source_imp.dart';
import 'infra/data_source/pokedata_data_source.dart';
import 'infra/repository/pokedata_repository_imp.dart';
import 'presenter/controller/home_controller.dart';
import 'presenter/home_page.dart';
import 'home_routes.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        // i.addLazySingleton<Dio>(() => Dio());

        Bind.factory<PokeDataDataSource>(
          (i) => PokeDataDataSourceImpl(
            dio: i(),
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
          (i) => HomeController(
            useCase: i<PokeDataUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HomeRoutes.homePage.route,
          child: (context, args) => HomePage(
            controller: context.read<HomeController>(),
          ),
        ),
      ];
}
