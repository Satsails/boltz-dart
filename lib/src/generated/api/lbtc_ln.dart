// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.28.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
import 'types.dart';
part 'lbtc_ln.freezed.dart';

@freezed
class LbtcLnSwap with _$LbtcLnSwap {
  const LbtcLnSwap._();
  const factory LbtcLnSwap({
    required String id,
    required SwapType kind,
    required Chain network,
    required KeyPair keys,
    required PreImage preimage,
    required String redeemScript,
    required String invoice,
    required int outAmount,
    required String scriptAddress,
    required String blindingKey,
    required String electrumUrl,
    required String boltzUrl,
  }) = _LbtcLnSwap;
  static Future<LbtcLnSwap> createReverseV1(
          {required String mnemonic,
          required int index,
          required int outAmount,
          required Chain network,
          required String electrumUrl,
          required String boltzUrl,
          required String pairHash,
          dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapCreateReverseV1(
          mnemonic: mnemonic,
          index: index,
          outAmount: outAmount,
          network: network,
          electrumUrl: electrumUrl,
          boltzUrl: boltzUrl,
          pairHash: pairHash,
          hint: hint);

  static Future<LbtcLnSwap> createSubmarineV1(
          {required String mnemonic,
          required int index,
          required String invoice,
          required Chain network,
          required String electrumUrl,
          required String boltzUrl,
          required String pairHash,
          dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapCreateSubmarineV1(
          mnemonic: mnemonic,
          index: index,
          invoice: invoice,
          network: network,
          electrumUrl: electrumUrl,
          boltzUrl: boltzUrl,
          pairHash: pairHash,
          hint: hint);

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<LbtcLnSwap> newInstance(
          {required String id,
          required SwapType kind,
          required Chain network,
          required KeyPair keys,
          required PreImage preimage,
          required String redeemScript,
          required String invoice,
          required int outAmount,
          required String outAddress,
          required String blindingKey,
          required String electrumUrl,
          required String boltzUrl,
          dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapNew(
          id: id,
          kind: kind,
          network: network,
          keys: keys,
          preimage: preimage,
          redeemScript: redeemScript,
          invoice: invoice,
          outAmount: outAmount,
          outAddress: outAddress,
          blindingKey: blindingKey,
          electrumUrl: electrumUrl,
          boltzUrl: boltzUrl,
          hint: hint);

  Future<String> reverseV1Claim(
          {required String outAddress, required int absFee, dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapReverseV1Claim(
        that: this,
        outAddress: outAddress,
        absFee: absFee,
      );

  Future<String> submarineV1Refund(
          {required String outAddress, required int absFee, dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapSubmarineV1Refund(
        that: this,
        outAddress: outAddress,
        absFee: absFee,
      );

  static Future<int> txSize({required LbtcLnSwap swap, dynamic hint}) =>
      BoltzCore.instance.api.lbtcLnSwapTxSize(swap: swap, hint: hint);
}
