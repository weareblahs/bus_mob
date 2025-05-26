import 'package:bus_mob/data/models/information.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/get_provider_stations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, required this.info});

  final Information info;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  List<String> br = [];
  String assetDir = '';
  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  void _init() async {
    final range = await getRouteRange(
      widget.info.routeId!,
      widget.info.fromSeqNo!,
      widget.info.toSeqNo!,
    );
    print("Range: $range");
    setState(() {
      br = range;
    });

    if (widget.info.infoType == "accident") {
      setState(() {
        assetDir = 'assets/carcrash_icon.svg';
      });
    }

    if (widget.info.infoType == "trafficJam") {
      setState(() {
        assetDir = 'assets/trafficjam_icon.svg';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(getRouteName(widget.info.routeId!)),
                ),
                Expanded(
                  flex: 5,
                  child: Text(widget.info.routeId!, textAlign: TextAlign.end),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("from", textAlign: TextAlign.center),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(br[0], style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text("to", textAlign: TextAlign.center),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              br[br.length - 1],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: SvgPicture.asset(assetDir)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
