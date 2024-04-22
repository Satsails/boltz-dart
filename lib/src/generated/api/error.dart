// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.28.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class BoltzError implements FrbException {
  final String kind;
  final String message;

  const BoltzError({
    required this.kind,
    required this.message,
  });

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<BoltzError> newInstance(
          {required String kind, required String message, dynamic hint}) =>
      BoltzCore.instance.api
          .boltzErrorNew(kind: kind, message: message, hint: hint);

  @override
  int get hashCode => kind.hashCode ^ message.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoltzError &&
          runtimeType == other.runtimeType &&
          kind == other.kind &&
          message == other.message;
}
