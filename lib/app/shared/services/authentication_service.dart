import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  LocalAuthentication localAuth = LocalAuthentication();

  Future initialize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('authentication') == false) return;

    final hasAuthentication = _prefs.getBool('authentication')!;
    if (hasAuthentication == false) return;

    bool _isSupported = await isSupported();
    if (_isSupported == false) {
      _prefs.setBool('authentication', false);
      return;
    }

    bool isAuthenticated = await authenticate();
    if (isAuthenticated) return;

    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', true);
  }

  Future<bool> isSupported() async {
    return await localAuth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await localAuth.authenticate(
        localizedReason: "Desbloqueie para acessar o Notas");
  }
}
