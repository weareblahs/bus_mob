import 'package:bus_mob/data/road_status_screens/add_info_landing.dart';
import 'package:bus_mob/data/road_status_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoadLandingScreen extends StatefulWidget {
  const RoadLandingScreen({super.key});

  @override
  State<RoadLandingScreen> createState() => _RoadLandingScreenState();
}

class _RoadLandingScreenState extends State<RoadLandingScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<AuthState>(
              stream: supabase.auth.onAuthStateChange,
              builder: (context, snapshot) {
                final session =
                    snapshot.hasData ? snapshot.data!.session : null;

                if (session == null) {
                  return const LoginSection();
                } else {
                  return const AddInfoSection();
                }
              },
            ),
          ),
          const Expanded(child: Placeholder()),
        ],
      ),
    );
  }
}
