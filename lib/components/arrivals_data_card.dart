import 'package:bus_mob/models/arrivals.dart';
import 'package:bus_mob/utils/get_traffic_info.dart';
import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ArrivalsDataCard extends StatefulWidget {
  const ArrivalsDataCard({super.key, required this.arrivals});
  final Arrivals arrivals;

  @override
  State<ArrivalsDataCard> createState() => _ArrivalsDataCardState();
}

class _ArrivalsDataCardState extends State<ArrivalsDataCard> {
  String msg = "";
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final trafficInfo = await getTrafficInfoTextCompact(
      widget.arrivals.seq!,
      widget.arrivals.route!,
    );

    if (trafficInfo != null) {
      setState(() {
        msg = trafficInfo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.arrivals.stopsAway!.isNegative)
        ? Align(
          alignment: Alignment.center,
          child: Text(
            passed(
              widget.arrivals.licensePlate!,
              widget.arrivals.stopsAway!.toDouble(),
            ),
            textAlign: TextAlign.center,
          ),
        )
        : Card(
          color: Colors.black,
          child: Column(
            children: [
              Row(
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
                                  widget.arrivals.licensePlate!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.fromLTRB(
                                    6,
                                    0,
                                    6,
                                    0,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      MapsLauncher.launchCoordinates(
                                        widget.arrivals.busLat!,
                                        widget.arrivals.busLon!,
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
                                widget.arrivals.duration! < 60
                                    ? lessThan1Min
                                    : getTimeFromDuration(
                                      widget.arrivals.duration!,
                                    ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                stopsAway(widget.arrivals.stopsAway!),
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
              if (msg != "")
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 12),
                  child: Text(
                    msg,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ),
            ],
          ),
        );
  }
}
