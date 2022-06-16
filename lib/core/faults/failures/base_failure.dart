import 'package:equatable/equatable.dart';

class BaseFailure extends Equatable {
  const BaseFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
