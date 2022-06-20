import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  BaseException({this.errorMessage, String? label, StackTrace? stackTrace}) {
    debugPrintStack(label: label, stackTrace: stackTrace);
  }

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
