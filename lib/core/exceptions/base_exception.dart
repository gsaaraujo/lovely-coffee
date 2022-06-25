import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  BaseException({String? errorMessage, StackTrace? stackTrace}) {
    debugPrintStack(
      label: '---> $errorMessage <---',
      stackTrace: stackTrace,
    );
  }

  @override
  List<Object?> get props => [];
}
