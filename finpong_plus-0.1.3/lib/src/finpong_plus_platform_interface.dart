//part of finpong_plus;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'finpong_plus_method_channel.dart';

abstract class FinpongPlusPlatform extends PlatformInterface {
  /// Constructs a FinpongPlusPlatform.
  FinpongPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static FinpongPlusPlatform _instance = MethodChannelFinpongPlus();

  /// The default instance of [FinpongPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelFinpongPlus].
  static FinpongPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FinpongPlusPlatform] when
  /// they register themselves.
  static set instance(FinpongPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
