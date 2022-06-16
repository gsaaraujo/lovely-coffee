import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  const BaseException({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
