import 'package:bus_mob/data/models/arrivals.dart';
import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ArrivalsDataCard extends StatelessWidget {
  const ArrivalsDataCard({super.key, required this.arrivals});
  final Arrivals arrivals;

  @override
  Widget build(BuildContext context) {
    return (arrivals.stopsAway!.isNegative)
        ? Align(
          alignment: Alignment.center,
          child: Text(
            passed(arrivals.licensePlate!, arrivals.stopsAway!.toDouble()),
            textAlign: TextAlign.center,
          ),
        )
        : Card(
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              arrivals.licensePlate!,
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.fromLTRB(6, 0, 6, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  MapsLauncher.launchCoordinates(
                                    arrivals.busLat!,
                                    arrivals.busLon!,
                                  );
                                },
                                child: Icon(Icons.map),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            arrivals.duration! < 60
                                ? lessThan1Min
                                : getTimeFromDuration(arrivals.duration!),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            stopsAway(arrivals.stopsAway!),
                            style: TextStyle(fontSize: 10),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
