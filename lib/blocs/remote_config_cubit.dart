import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final FirebaseRemoteConfig _remoteConfig;

  late final StreamSubscription _internetSubscription;

  RemoteConfigCubit(this._remoteConfig) : super(RemoteConfigLoading()) {
    fetchRemoteConfig();
    _internetSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen(_onInternetConnectionChanged);
  }

  void _onInternetConnectionChanged(status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        fetchRemoteConfig();
        break;
      case InternetConnectionStatus.disconnected:
        emit(
          const RemoteConfigError(
            error: 'Для работы приложения необходим доступ к сети',
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _internetSubscription.cancel();
    // _remoteConfigSubscription.cancel();
    return super.close();
  }

  Future<bool> checkIsEmu() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final em = await deviceInfo.androidInfo;
    var phoneModel = em.model;
    var buildProduct = em.product;
    var buildHardware = em.hardware;
    var result = (em.fingerprint.startsWith("generic") ||
        phoneModel.contains("google_sdk") ||
        phoneModel.contains("droid4x") ||
        phoneModel.contains("Emulator") ||
        phoneModel.contains("Android SDK built for x86") ||
        em.manufacturer.contains("Genymotion") ||
        buildHardware == "goldfish" ||
        buildHardware == "vbox86" ||
        buildProduct == "sdk" ||
        buildProduct == "google_sdk" ||
        buildProduct == "sdk_x86" ||
        buildProduct == "vbox86p" ||
        em.brand.contains('google') ||
        em.board.toLowerCase().contains("nox") ||
        em.bootloader.toLowerCase().contains("nox") ||
        buildHardware.toLowerCase().contains("nox") ||
        !em.isPhysicalDevice ||
        buildProduct.toLowerCase().contains("nox"));
    if (result) return true;
    result = result ||
        (em.brand.startsWith("generic") && em.device.startsWith("generic"));
    if (result) return true;
    result = result || ("google_sdk" == buildProduct);
    return result;
  }

  Future<void> fetchRemoteConfig() async {
    try {
      final isEmu = await checkIsEmu();
      if (isEmu) {
        emit(RemoteConfigSportNews());
        return;
      }
      emit(RemoteConfigLoading());

      final prefs = await SharedPreferences.getInstance();
      final urlInCache = prefs.getString('savedUrl');

      if (urlInCache != null) {
        emit(RemoteConfigLoaded(url: urlInCache));
        return;
      }

      await _fetchAndActivateRemoteConfig();
      final url = _remoteConfig.getString('url');

      if (url.isNotEmpty) {
        _saveUrlToSharedPreferences(url);
        emit(RemoteConfigLoaded(url: url));
      } else {
        emit(RemoteConfigSportNews());
      }
    } catch (e) {
      emit(RemoteConfigError(error: e.toString()));
    }
  }

  Future<void> _fetchAndActivateRemoteConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  void _saveUrlToSharedPreferences(String url) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savedUrl', url);
  }
}
