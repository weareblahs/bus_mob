import 'package:bus_mob/data/components/data_card.dart';
import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:bus_mob/utils/gtfs_generate.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BusBasicInfo> info = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final busInfo = await generateGtfs("rapidPenang", "101A");
    setState(() {
      info = busInfo;
    });
    debugPrint(busInfo.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: info.length,
          itemBuilder: (context, index) => DataCard(busInfo: info[index]),
        ),
      ),
    );
  }
}
