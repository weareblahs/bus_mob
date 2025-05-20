import 'package:bus_mob/data/container/tab_container.dart';
import 'package:go_router/go_router.dart';

var navigation = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => TabContainer(),
    ),
  ],
);
