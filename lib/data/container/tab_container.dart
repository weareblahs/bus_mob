import 'package:bus_mob/data/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabContainer extends StatefulWidget {
  const TabContainer({super.key});

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  Widget _tabBarItem(String title, IconData icon) {
    return SizedBox(
      height: 50,
      child: Column(children: [Icon(icon), Text(title)]),
    );
  }

  void _navigateToLake() {}

  void _navigateToPosts() {}

  //drawer navigation
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: const TabBarView(children: [HomeScreen(), Placeholder()]),

        bottomNavigationBar: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.blueGrey,
          tabs: [
            _tabBarItem("Bus status", Icons.bus_alert),
            _tabBarItem("Settings", Icons.settings),
          ],
        ),
      ),
    );
  }
}
