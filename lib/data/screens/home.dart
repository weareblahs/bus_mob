import 'dart:async';

import 'package:bus_mob/data/components/data_card.dart';
import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/data/navigation/navigation.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/download_provider_to_local_storage.dart';
import 'package:bus_mob/utils/gtfs_generate.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    if (config.get("providerRoutes") == null) {
      downloadProvider();
      _continue();
    }
    _continue();
  }

  void _continue() async {
    providers = dropdownProviders();
    final busInfo = await generateGtfs(
      config.get("provider"),
      config.get("route"),
    );
    setState(() {
      info = busInfo;
    });
  }

  Future<void> setRoute(String provider, String route) async {
    final busInfo = await generateGtfs(provider, route);
    setState(() {
      info = busInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final busInfo = await generateGtfs(
          config.get("provider"),
          config.get("route"),
        );
        setState(() {
          info = busInfo;
        });
      },
      child: Scaffold(
        // swipe down to refresh route info
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
              child: DropdownMenu(
                
                dropdownMenuEntries: providers,
                onSelected: (value) async {
                  config.put("route", value);
                  info = [];
                  final busInfo = await generateGtfs(
                    config.get("provider"),
                    config.get("route"),
                  );
                  setState(() {
                    info = busInfo;
                  });
                },
              ),
            ),
            Visibility(
              visible: msg != "",
              child: Expanded(child: Text("${config.get("tempMsgData")}")),
            ),
            Visibility(
              visible: msg == "",
              child: Expanded(
                child: SafeArea(
                  child: ListView.builder(
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
