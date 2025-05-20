import 'package:bus_mob/data/models/bus_basic_info.dart';
import 'package:flutter/material.dart';

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
            Row(
              children: [
                Text(busInfo.licensePlate!, textAlign: TextAlign.start),
                Text(busInfo.speed.toString(), textAlign: TextAlign.end),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
