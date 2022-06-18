// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class SplashStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashInitialState extends SplashStates {}

class SplashLoadingState extends SplashStates {}

class SplashRedirectToSignInState extends SplashStates {}

class SplashRedirectToHomeState extends SplashStates {}

class SplashFailedState extends SplashStates {
  SplashFailedState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
