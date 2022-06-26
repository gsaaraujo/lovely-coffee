import 'package:flutter_modular/flutter_modular.dart';
import 'package:lovely_coffee/modules/home/external/datasources/favorite_products_datasource_impl.dart';
import 'package:lovely_coffee/modules/home/external/datasources/products_datasource_impl.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_cubit.dart';
import 'package:lovely_coffee/modules/home/presenter/ui/pages/home_page.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/products_repository_impl.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_products_usecase_impl.dart';
import 'package:lovely_coffee/modules/home/infra/repositories/favorite_products_repository_impl.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_user_favorite_products_usecase_impl.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/add_or_remove_product_to_favorites_usecase_impl.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // cubits
        Bind.lazySingleton((i) => HomeCubit(i(), i(), i(), i())),

        // usecases
        Bind.factory((i) => GetAllProductsUsecaseImpl(i())),
        Bind.factory((i) => GetAllUserFavoriteProductsUsecaseImpl(i())),
        Bind.factory((i) => AddOrRemoveProductToFavoritesUsecaseImpl(i())),

        // repositories
        Bind.factory((i) => ProductsRepositoryImpl(i(), i(), i(), i())),
        Bind.factory((i) => FavoriteProductsRepositoryImpl(i(), i())),

        // datasources
        Bind.factory((i) => ProductsDatasourceImpl(i())),
        Bind.factory((i) => FavoriteProductsDatasourceImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
