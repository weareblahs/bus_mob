import 'dart:async';

import 'package:bus_mob/data/components/data_card.dart';
import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/download_provider_to_local_storage.dart';
import 'package:bus_mob/utils/gtfs_generate.dart';
import 'package:bus_mob/utils/variables.dart';
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
          const snackBar = SnackBar(content: Text(dataRefreshSnackbar));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await _reload();
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
        // swipe down to refresh route info
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
              child: Column(
                children: [
                  if (providers.isNotEmpty)
                    DropdownMenu(
                      dropdownMenuEntries: providers,
                      initialSelection: config.get("route"),
                      onSelected: (value) async {
                        config.put("route", value);
                        _refresh();
                      },
                    ),
                ],
              ),
            ),
            if (info.isEmpty && !isLoading)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        dataUnavailableHeader,
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        dataUnavailableText,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            if (isLoading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(padding: EdgeInsets.all(12.0), child: Text(msg)),
                    ],
                  ),
                ),
              ),
            if (!isLoading)
              Expanded(
                child: SafeArea(
                  top: false,
                  maintainBottomViewPadding: false,
                  child: Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(6, 16, 6, 16),
                      itemCount: info.length,
                      itemBuilder:
                          (context, index) => DataCard(busInfo: info[index]),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
