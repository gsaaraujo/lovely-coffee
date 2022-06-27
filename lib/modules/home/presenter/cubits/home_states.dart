import 'package:equatable/equatable.dart';
import 'package:lovely_coffee/core/exceptions/base_exception.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';

abstract class HomeStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSucceedState extends HomeStates {
  HomeSucceedState(this.productList, this.userLocalStorage);

  final List<ProductEntity> productList;
  final UserLocalStorageEntity userLocalStorage;
}

class HomeFailedState extends HomeStates {
  HomeFailedState({required this.exception});

  final BaseException exception;

  @override
  List<Object?> get props => [exception];
}
