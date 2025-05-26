import 'package:bus_mob/utils/get_provider_stations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SelectStationsScreen extends StatefulWidget {
  const SelectStationsScreen({super.key});
  @override
  State<SelectStationsScreen> createState() => _SelectStationsScreenState();
}

class _SelectStationsScreenState extends State<SelectStationsScreen> {
  String fromStation = "";
  var rangeText = "";
  String toStation = "";
  List<DropdownMenuEntry> stations = [];
  var config = Hive.box("busConfig");

  Future<void> _getStations() async {
    var route = config.get("tempStoreRoute");
    final res = await getProviderStations(route);
    setState(() {
      stations = res;
    });
  }

  @override
  void initState() {
    _getStations();
    super.initState();
  }

  void calculate() {
    int range = int.parse(toStation) - int.parse(fromStation);
    if (range <= 0) {
      setState(() {
        rangeText =
            "Invalid station range. Please select a valid range and try again.";
      });
    } else {
      setState(() {
        rangeText = "Includes $range station${range > 1 ? "s" : ""}";
      });
    }
  }

  void _continue() {
    if (fromStation != "" && toStation != "") {
      config.put("tempFromStation", fromStation);
      config.put("tempToStation", toStation);
      context.pushReplacementNamed("selectType");
    }
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
                  Text(
                    "Select a station range",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("From which station?"),
                        Padding(
                          padding: const EdgeInsetsGeometry.fromLTRB(
                            24,
                            4,
                            24,
                            4,
                          ),
                          child: DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                fromStation = value;
                                calculate();
                              });
                            },
                            width: double.infinity,
                            dropdownMenuEntries: stations,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("To which station?"),
                        Padding(
                          padding: const EdgeInsetsGeometry.fromLTRB(
                            24,
                            4,
                            24,
                            4,
                          ),
                          child: DropdownMenu(
                            onSelected: (value) {
                              setState(() {
                                toStation = value;
                                calculate();
                              });
                            },
                            width: double.infinity,
                            dropdownMenuEntries: stations,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(16, 0, 16, 0),
                    child: Text(rangeText, textAlign: TextAlign.center),
                  ),
                  Visibility(
                    visible: fromStation != "" && toStation != "",
                    child: ElevatedButton(
                      onPressed: _continue,
                      child: Text("Next"),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
