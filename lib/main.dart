import 'package:flutter/material.dart';
import 'package:flutter_notas/app/app_module.dart';
import 'package:flutter_notas/app/shared/services/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AuthenticationService().initialize();

  runApp(AppModule());
}
