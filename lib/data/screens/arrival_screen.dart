import 'package:bus_mob/data/components/arrivals_data_card.dart';
import 'package:bus_mob/data/models/arrivals.dart';
import 'package:bus_mob/utils/get_provider_stations.dart';
import 'package:bus_mob/utils/search_arrivals.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ArrivalScreen extends StatefulWidget {
  const ArrivalScreen({super.key});

  @override
  State<ArrivalScreen> createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  List<DropdownMenuEntry> stations = [];
  String selectValue = "";
  final config = Hive.box("busConfig");
  bool isLoading = false;
  List<Arrivals> displayData = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final route = config.get("route");

    final data = await getProviderStations(route);
    setState(() {
      stations = data;
    });
  }

  Future<void> _searchData() async {
    setState(() {
      isLoading = true;
    });
    final res = await searchArrivals(
      int.parse(selectValue),
      config.get("route"),
    );
    setState(() {
      displayData = res;
      isLoading = false;
    });
  }

  Future<void> _refresh() async {
    if (selectValue != "") {
      _searchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 36, 32, 16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              if (stations.isEmpty) Center(child: CircularProgressIndicator()),
              if (stations.isNotEmpty)
                DropdownMenu(
                  dropdownMenuEntries: stations,
                  onSelected: (value) {
                    setState(() {
                      selectValue = value;
                    });
                    _searchData();
                  },
                ),
              if (displayData.isNotEmpty)
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _searchData,
                    child: Column(
                      children: [
                        if (isLoading) CircularProgressIndicator(),
                        if (stations.isNotEmpty && !isLoading)
                          Expanded(
                            child: ListView.builder(
                              itemCount: displayData.length,
                              itemBuilder:
                                  (context, index) => ArrivalsDataCard(
                                    arrivals: displayData[index],
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
