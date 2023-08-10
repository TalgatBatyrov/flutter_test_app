import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'remote_config_state.dart';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final FirebaseRemoteConfig _remoteConfig;

  late final StreamSubscription _internetSubscription;
  late final StreamSubscription _remoteConfigSubscription;

  RemoteConfigCubit(this._remoteConfig) : super(RemoteConfigLoading()) {
    _internetSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen(_onInternetConnectionChanged);

    _remoteConfigSubscription =
        _remoteConfig.onConfigUpdated.listen((event) async {
      emit(RemoteConfigLoading());

      await _remoteConfig.activate();
      final url = _remoteConfig.getString('take');

      if (url.isNotEmpty) {
        _saveUrlToSharedPreferences(url);
        emit(RemoteConfigLoaded(url: url));
      } else {
        emit(RemoteConfigSportNews());
      }
    });
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
    _remoteConfigSubscription.cancel();
    return super.close();
  }

  Future<void> fetchRemoteConfig() async {
    try {
      emit(RemoteConfigLoading());

      final prefs = await SharedPreferences.getInstance();
      final urlInCache = prefs.getString('savedUrl');

      print('urlInCache: $urlInCache');
      if (urlInCache != null) {
        emit(RemoteConfigLoaded(url: urlInCache));
        return;
      }

      await _fetchAndActivateRemoteConfig();
      final url = _remoteConfig.getString('take');

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
