import '../components/info_card.dart';
import '../models/information.dart';
import '../repo/repo.dart';
import '../road_status_screens/add_info_landing.dart';
import '../road_status_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoadLandingScreen extends StatefulWidget {
  const RoadLandingScreen({super.key});

  @override
  State<RoadLandingScreen> createState() => _RoadLandingScreenState();
}

class _RoadLandingScreenState extends State<RoadLandingScreen> {
  final supabase = Supabase.instance.client;
  List<Information> data = [];
  bool isLoading = false;
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
    });
    final res = await getInfoList();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  void _init() async {
    Hive.box("busConfig").watch(key: "dataChanged").listen((event) {
      if (event.value) {
        _refresh();
      }
    });
    _refresh();
  }

  void _redirect() async {
    Hive.box("busConfig").put("dataChanged", false);
    final res = await context.pushNamed("selectRoute");
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
            flex: 7,
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
          if (isLoading)
            Expanded(
              flex: 12,
              child: Center(child: CircularProgressIndicator()),
            ),
          if (!isLoading)
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
