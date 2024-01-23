import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_fusion/features/home/domain/repository/fusion_repository.dart';
import 'package:poke_fusion/features/home/domain/usecases/fusion_usecase.dart';
import 'package:poke_fusion/features/home/external/fusion_data_source_imp.dart';
import 'package:poke_fusion/features/home/infra/data_source/fusion_data_source.dart';
import 'package:poke_fusion/features/home/infra/repository/fusion_repository_imp.dart';

import 'presenter/controller/home_controller.dart';
import 'presenter/pages/home_page.dart';
import 'home_routes.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory<FusionDataSource>(
          (i) => FusionDataSourceImp(
            clientHttp: i(),
          ),
        ),
        Bind.factory<FusionRepository>(
          (i) => FusionRepositoryImp(
            dataSource: i<FusionDataSource>(),
          ),
        ),
        Bind.factory<FusionUseCase>(
          (i) => FusionUsecaseImp(
            repository: i<FusionRepository>(),
          ),
        ),
        Bind.factory(
          (i) => HomeController(
            useCase: i<FusionUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HomeRoutes.homePage.route,
          child: (context, args) => HomePage(
            controller: context.read<HomeController>(),
            pokeData: args.data,
          ),
        ),
      ];
}
