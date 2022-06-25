import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_states.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_products_usecase_impl.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_user_favorite_products_usecase_impl.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/add_or_remove_product_to_favorites_usecase_impl.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(
    this._localStorageService,
    this._getAllProductsUsecase,
    this._getAllUserFavoriteProductsUsecase,
    this._addOrRemoveProductToFavoritesUsecase,
  ) : super(HomeInitialState());

  final GetAllProductsUsecase _getAllProductsUsecase;
  final GetAllUserFavoriteProductsUsecase _getAllUserFavoriteProductsUsecase;

  final AddOrRemoveProductToFavoritesUsecase
      _addOrRemoveProductToFavoritesUsecase;

  final LocalStorageService _localStorageService;

  void fetchInitialData() async {
    emit(HomeLoadingState());

    final productList = await _getAllProductsUsecase();
    final userSigned = await _localStorageService.getUser();

    productList.fold((exception) {
      if (exception is NoDeviceConnectionException) {
        emit(HomeFailedState(exception: exception));
        return;
      }

      if (exception is UnknownException) {
        emit(HomeFailedState(exception: exception));
        return;
      }
    }, (productList) {
      emit(HomeSucceedState(userSigned, productList));
    });
  }
}
