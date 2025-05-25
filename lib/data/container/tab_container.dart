import 'package:bus_mob/data/settings/settings_page.dart';
import 'package:bus_mob/data/screens/home.dart';
import 'package:bus_mob/data/screens/road_landing_screen.dart';
import 'package:flutter/material.dart';

class TabContainer extends StatefulWidget {
  const TabContainer({super.key});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  Widget _tabBarItem(String title, IconData icon) {
    return SizedBox(
      height: 48,
      child: Column(children: [Icon(icon), Text(title)]),
    );
  }

  //drawer navigation
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          children: [HomeScreen(), RoadLandingScreen(), SettingsPage()],
        ),
        bottomNavigationBar: TabBar(
          labelPadding: EdgeInsets.all(8),
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.blueGrey,
          tabs: [
            _tabBarItem("Bus status", Icons.bus_alert),
            _tabBarItem("Road status", Icons.report),
            _tabBarItem("Settings", Icons.settings),
          ],
        ),
      ),
    );
  }
}
