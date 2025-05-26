import 'package:bus_mob/data/components/road_status_screens/login.dart';
import 'package:flutter/material.dart';

class RoadLandingScreen extends StatefulWidget {
  const RoadLandingScreen({super.key});

  @override
  State<RoadLandingScreen> createState() => _RoadLandingScreenState();
}

class _RoadLandingScreenState extends State<RoadLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: LoginSection()),
          Expanded(child: Placeholder()),
        ],
      ),
    );
  }
}
