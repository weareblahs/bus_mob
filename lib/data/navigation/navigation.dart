import 'package:bus_mob/data/container/tab_container.dart';
import 'package:bus_mob/data/screens/provider_selection.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

final config = Hive.box('busConfig');
var navigation = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder:
          (context, state) =>
              (config.get("provider") == null)
                  ? ProviderSelectionScreen()
                  : TabContainer(),
    ),
  ],
);
