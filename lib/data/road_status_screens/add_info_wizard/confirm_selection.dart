import 'package:bus_mob/data/models/information.dart';
import 'package:bus_mob/data/repo/repo.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/get_provider_stations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfirmSelectionScreen extends StatefulWidget {
  const ConfirmSelectionScreen({super.key});

  @override
  State<ConfirmSelectionScreen> createState() => _ConfirmSelectionScreenState();
}

class _ConfirmSelectionScreenState extends State<ConfirmSelectionScreen> {
  final config = Hive.box("busConfig");
  final supabase = Supabase.instance.client;
  List<String> routeRange = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final rr = await getRouteRange(
      config.get("tempStoreRoute"),
      config.get("tempFromStation"),
      config.get("tempToStation"),
    );
    setState(() {
      routeRange = rr;
    });
  }

  void _submit() async {
    submitInfo(
      Information(
        routeId: config.get("tempStoreRoute"),
        fromSeqNo: config.get("tempFromStation"),
        toSeqNo: config.get("tempToStation"),
        infoType: config.get("tempType"),
        userId: supabase.auth.currentUser!.id,
      ),
    );
    config.delete("tempStoreRoute");
    config.delete("tempFromStation");
    config.delete("tempToStation");
    config.delete("tempType");
    context.pop('add');
    const snackBar = SnackBar(content: Text("Data addition successful"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Confirm submission", style: TextStyle(fontSize: 28)),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text("Route"),
                    Text(
                      getRouteName(config.get("tempStoreRoute")),
                      style: TextStyle(fontSize: 24),
                    ),
                    Text("Station range"),
                    Wrap(
                      children: [
                        for (final rr in routeRange)
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Text(rr),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "Total ${routeRange.length} stations",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text("Type"),
                    if (config.get("tempType") == "accident")
                      Text("Accident", style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            ),
            Spacer(),
            Text(
              "Please ensure that the data is accurate. Data will be deleted 2 hours after your submission.",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(onPressed: _submit, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
