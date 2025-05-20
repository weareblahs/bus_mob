import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DataCard extends StatelessWidget {
  const DataCard({super.key, required this.busInfo});

  final BusBasicInfo busInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Text("near ${busInfo.currentParsedLocation}"),
                  ),
                  Expanded(flex: 1, child: Spacer()),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("button pressed");
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
