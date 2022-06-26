import 'package:bloc/bloc.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_states.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/application/services/local_storage/local_storage_service.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/get_all_products_usecase_impl.dart';
import 'package:lovely_coffee/application/services/secure_local_storage/secure_local_storage_service.dart';
import 'package:lovely_coffee/modules/home/domain/usecasese/add_or_remove_product_to_favorites_usecase_impl.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(
    this._localStorageService,
    this._secureLocalStorageService,
    this._getAllProductsUsecase,
    this._addOrRemoveProductToFavoritesUsecase,
  ) : super(HomeInitialState());

  final GetAllProductsUsecase _getAllProductsUsecase;

  final AddOrRemoveProductToFavoritesUsecase
      _addOrRemoveProductToFavoritesUsecase;

  final LocalStorageService _localStorageService;
  final SecureLocalStorageService _secureLocalStorageService;

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

  Future<bool> addOrRemoveProductToFavorites(String productId) async {
    final userSigned = await _localStorageService.getUser();
    final productList = await _addOrRemoveProductToFavoritesUsecase(
      productId,
      userSigned.uid,
    );

    return productList.fold((exception) {
      return false;
    }, (isSuccess) {
      return true;
    });
  }

  Future<UserLocalStorageEntity> getUserLocalStorage() {
    return _localStorageService.getUser();
  }

  void signOut() {
    _localStorageService.deleteUser();
    _secureLocalStorageService.deleteTokens();
  }
}
