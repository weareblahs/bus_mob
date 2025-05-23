import 'dart:async';

import 'package:bus_mob/data/components/data_card.dart';
import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/download_provider_to_local_storage.dart';
import 'package:bus_mob/utils/gtfs_generate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restart_app/restart_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final GlobalKey<State<HomeScreen>> globalKey =
      GlobalKey<_HomeScreenState>();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BusBasicInfo> info = [];
  List<DropdownMenuEntry> providers = [];
  var config = Hive.box("busConfig");
  String msg = "";
  bool isLoading = false;
  bool isRefresh = false;
  Timer? timer;
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (config.get("providerRoutes") == null) {
      downloadProvider();
      Restart.restartApp();
      _continue();
    }
    _continue();
  }

  Future<bool> _refreshScript() async {
    final busInfo = await generateGtfs(
      config.get("provider"),
      config.get("route"),
      _updateMsg,
    );
    setState(() {
      info = busInfo;
    });
    setState(() {
      isLoading = false;
    });
    return true;
  }

  void _updateMsg(String message) {
    setState(() {
      msg = message;
    });
  }

  Future<bool> _refresh() async {
    setState(() {
      isLoading = true;
    });

    return _refreshScript();
  }

  Future<bool> _reload() async {
    setState(() {
      isLoading = false;
    });

    return _refreshScript();
  }

  void _startReloadTimer() async {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      final time = DateTime.now().second;
      if (time == 30 || time == 0) {
        if (!isLoading) {
          const snackBar = SnackBar(
            content: Text('Possible new data found! Refreshing...'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await _reload();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      }
    });
  }

  void _continue() async {
    setState(() {
      providers = dropdownProviders();
      isLoading = true;
    });
    _startReloadTimer();
    final busInfo = await generateGtfs(
      config.get("provider"),
      config.get("route"),
      _updateMsg,
    );
    setState(() {
      info = busInfo;
      isLoading = false;
    });
  }

  Future<void> setRoute(String provider, String route) async {
    final busInfo = await generateGtfs(provider, route, _updateMsg);
    setState(() {
      info = busInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reload,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
          children: [
            if (providers.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: DropdownMenu(
                  dropdownMenuEntries: providers,
                  initialSelection: config.get("route"),
                  onSelected: (value) async {
                    config.put("route", value);
                    _reload();
                  },
                ),
              ),
            const SizedBox(height: 16),
            if (info.isEmpty && !isLoading)
              Column(
                children: const [
                  Text(
                    "Realtime data unavailable.",
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please select another route and try again.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            if (isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(msg),
                    ),
                  ],
                ),
              ),
            if (!isLoading && info.isNotEmpty)
              ...info.map((item) => DataCard(busInfo: item)),
          ],
        ),
      ),
    );
  }
}
