import 'package:bus_mob/data/navigation/navigation.dart';
import 'package:bus_mob/utils/gtfs_generate.dart';
import 'package:flutter/material.dart';

void main() {
  final data = generateGtfs('rapidPenang', '101A');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'bus?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: navigation,
    );
  }
}
