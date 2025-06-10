import '../models/bus_basic_info.dart';
import '../utils/variables.dart';
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
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      busInfo.licensePlate ?? "Unknown",
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
                          (busInfo.speed ?? 0) == 0
                              ? "Waiting"
                              : "${(busInfo.speed ?? 0).toDouble().toStringAsFixed(0)}km/h",
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
                    (busInfo.busStations?.currentStation != null &&
                            busInfo.busStations?.currentStation !=
                                "Unknown station")
                        ? [
                          Text(
                            busInfo.busStations?.previousStation ?? "Unknown",
                          ),
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
                                    padding: EdgeInsets.fromLTRB(
                                      8.0,
                                      8.0,
                                      8.0,
                                      0,
                                    ),
                                    child: Text(
                                      busInfo.busStations?.currentStation ??
                                          "Unknown",
                                      style: TextStyle(
                                        fontSize: 35,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if ((busInfo.orsData?.duration ?? -1.0) !=
                                      -1.0)
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Text(
                                        stationRemaining(
                                          busInfo.orsData?.distance ?? 0.0,
                                          busInfo.orsData?.duration ?? 0.0,
                                        ),
                                        style: TextStyle(height: 0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Text(busInfo.busStations?.nextStation ?? "Unknown"),
                        ]
                        : [],
              ),
            ),
            if (busInfo.trafficInfo != null)
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  color: Colors.orange,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: Text(
                      busInfo.trafficInfo!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      busInfo.currentParsedLocation ??
                          "Failed to retrieve location",
                    ),
                  ),
                  Expanded(flex: 1, child: Spacer()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed:
                          (busInfo.latitude != null &&
                                  busInfo.longitude != null)
                              ? () {
                                MapsLauncher.launchCoordinates(
                                  busInfo.latitude!,
                                  busInfo.longitude!,
                                );
                              }
                              : null,
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
