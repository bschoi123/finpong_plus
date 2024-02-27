//part of finpong_plus;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'finpong_plus_platform_interface.dart';



/// An implementation of [FinpongPlusPlatform] that uses method channels.
class MethodChannelFinpongPlus extends FinpongPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('finpong_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
