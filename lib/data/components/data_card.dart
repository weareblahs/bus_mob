import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DataCard extends StatelessWidget {
  const DataCard({super.key, required this.busInfo});

  final BusBasicInfo busInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 4),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      busInfo.licensePlate!,
                      textAlign: TextAlign.left,
                      style: TextStyle(),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          busInfo.speed! == 0
                              ? "Waiting"
                              : "${busInfo.speed!.toDouble().toStringAsFixed(0)}km/h",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                children:
                    (busInfo.busStations!.currentStation! != "Unknown station")
                        ? [
                          Text(busInfo.busStations!.previousStation!),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      busInfo.busStations!.currentStation!,
                                      style: TextStyle(
                                        fontSize: 35,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(busInfo.busStations!.nextStation!),
                        ]
                        : [],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(busInfo.currentParsedLocation!),
                  ),
                  Expanded(flex: 1, child: Spacer()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        MapsLauncher.launchCoordinates(
                          busInfo.latitude!,
                          busInfo.longitude!,
                        );
                      },
                      child: Icon(Icons.map),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
