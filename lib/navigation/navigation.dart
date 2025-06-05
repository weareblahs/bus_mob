import '../container/tab_container.dart';
import '../road_status_screens/add_info_wizard/confirm_selection.dart';
import '../road_status_screens/add_info_wizard/select_route.dart';
import '../road_status_screens/add_info_wizard/select_stations.dart';
import '../road_status_screens/add_info_wizard/select_type.dart';
import '../screens/provider_selection.dart';
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

    // add info wizard screens
    // this wizard has 4 steps, while the path is '/addInfo/(STEP_NUMBER)'
    GoRoute(
      name: 'selectRoute',
      path: '/addInfo/1',
      builder: (context, state) => SelectRouteScreen(),
    ),
    GoRoute(
      name: 'selectStations',
      path: '/addInfo/2',
      builder: (context, state) => SelectStationsScreen(),
    ),
    GoRoute(
      name: 'selectType',
      path: '/addInfo/3',
      builder: (context, state) => SelectTypeScreen(),
    ),
    GoRoute(
      name: 'confirmSelection',
      path: '/addInfo/4',
      builder: (context, state) => ConfirmSelectionScreen(),
    ),
  ],
);
