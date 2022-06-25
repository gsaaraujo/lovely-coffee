import 'package:equatable/equatable.dart';

abstract class SignUpStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSucceedState extends SignUpStates {}

class SignUpFailedState extends SignUpStates {
  SignUpFailedState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
