import '../models/information.dart';
import '../repo/repo.dart';
import '../../utils/convert_providers.dart';
import '../../utils/get_provider_stations.dart';
import '../../utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:slideable/slideable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, required this.info});

  final Information info;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends ResumableState<InfoCard> {
  List<String> br = [];
  String assetDir = '';
  String type = '';
  final supabase = Supabase.instance.client.auth.currentUser?.id;
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
        type = accident;
      });
    }

    if (widget.info.infoType == "trafficJam") {
      setState(() {
        assetDir = 'assets/trafficjam_icon.svg';
        type = trafficJam;
      });
    }
  }

  void _deleteItem() {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(confirm),
            content: Text(deleteInfoConfirmationMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'selection_declined'),
                child: const Text(cancel),
              ),
              TextButton(
                onPressed: () {
                  deleteInfo(widget.info);
                  Navigator.pop(context, 'item_deleted');
                  Hive.box("busConfig").put("dataChanged", true);
                },
                child: const Text(delete),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return br.isNotEmpty
        ? Slideable(
          items: <ActionItems>[
            if (supabase == widget.info.userId)
              ActionItems(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPress: _deleteItem,
                backgroudColor: Colors.transparent,
              ),
          ],
          child: Card(
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
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                    from,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    br[0],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(to, textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    br[br.length - 1],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
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
          ),
        )
        : Container();
  }
}
