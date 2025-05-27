import 'dart:math';

import 'package:bus_mob/data/components/info_card.dart';
import 'package:bus_mob/data/models/information.dart';
import 'package:bus_mob/data/repo/repo.dart';
import 'package:bus_mob/data/road_status_screens/add_info_landing.dart';
import 'package:bus_mob/data/road_status_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoadLandingScreen extends StatefulWidget {
  const RoadLandingScreen({super.key});

  @override
  State<RoadLandingScreen> createState() => _RoadLandingScreenState();
}

class _RoadLandingScreenState extends State<RoadLandingScreen> {
  final supabase = Supabase.instance.client;
  List<Information> data = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _refresh() async {
    final res = await getInfoList();
    setState(() {
      data = res;
    });
  }

  void _init() async {
    _refresh();
    print(data.length);
  }

  void _redirect() async {
    final res = await context.pushNamed("selectRoute");
    print(res);
    if (res == null) {
      _init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: StreamBuilder<AuthState>(
              stream: supabase.auth.onAuthStateChange,
              builder: (context, snapshot) {
                final session =
                    snapshot.hasData ? snapshot.data!.session : null;

                if (session == null) {
                  return const LoginSection();
                } else {
                  return AddInfoSection(redirect: _redirect);
                }
              },
            ),
          ),
          Expanded(
            flex: 12,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                itemCount: data.length,
                itemBuilder: (context, index) => InfoCard(info: data[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
