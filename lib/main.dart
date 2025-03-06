import 'package:flutter/material.dart';
import 'package:tutorme/app/app.dart';
import 'package:tutorme/app/di/di.dart';
import 'package:tutorme/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  // await Hive.initFlutter();
  // Hive.registerAdapter(UserHiveModelAdapter());

  runApp(
    const MyApp(),
  );
}
