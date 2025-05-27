import 'package:bus_mob/data/models/information.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/get_provider_stations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instant/instant.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, required this.info});

  final Information info;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  List<String> br = [];
  String assetDir = '';
  String type = '';
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final range = await getRouteRange(
      widget.info.routeId!,
      widget.info.fromSeqNo!,
      widget.info.toSeqNo!,
    );
    setState(() {
      br = range;
    });

    if (widget.info.infoType == "accident") {
      setState(() {
        assetDir = 'assets/carcrash_icon.svg';
        type = "Accident";
      });
    }

    if (widget.info.infoType == "trafficJam") {
      setState(() {
        assetDir = 'assets/trafficjam_icon.svg';
        type = "Traffic jam";
      });
    }
    final supabase = Supabase.instance.client;
    final User? user = supabase.auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return br.isNotEmpty
        ? Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                        child: Text(widget.info.routeId!),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(getRouteName(widget.info.routeId!)),
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
                                child: Text(
                                  "from",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  br[0],
                                  style: TextStyle(fontSize: 20),
                                ),
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
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SvgPicture.asset(assetDir),
                          SizedBox(height: 4),
                          Text(type),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        : Container();
  }
}
