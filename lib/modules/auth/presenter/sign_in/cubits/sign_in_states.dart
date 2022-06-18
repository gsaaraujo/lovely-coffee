import 'package:equatable/equatable.dart';

abstract class SignInStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInInitialState extends SignInStates {}

class SignInLoadingState extends SignInStates {}

class SignInSucceedState extends SignInStates {}

class SignInFailedState extends SignInStates {
  SignInFailedState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
