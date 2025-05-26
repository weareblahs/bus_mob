import 'package:bus_mob/data/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  // initialize hive config box if not initialized
  await Hive.openBox('busConfig');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'bus?',
      theme: ThemeData.dark(),
      routerConfig: navigation,
    );
  }
}
