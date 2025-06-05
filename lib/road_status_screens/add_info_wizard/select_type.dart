import '../../utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({super.key});

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  String type = "";
  String text = "";
  final config = Hive.box("busConfig");
  void _selected(String types) {
    if (types == "accident") {
      setState(() {
        text = accident;
        type = types;
      });
    }

    if (types == "trafficJam") {
      setState(() {
        text = trafficJam;
        type = types;
      });
    }
  }

  void _finalize() {
    config.put("tempType", type);
    context.pushReplacementNamed("confirmSelection");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text(selectType, style: TextStyle(fontSize: 28))],
              ),
            ),
            Expanded(
              flex: 8,
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _selected("accident");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/carcrash_icon.svg',
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          _selected("trafficJam");
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            'assets/trafficjam_icon.svg',
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (type != "") Text(text),
                  if (type != "")
                    ElevatedButton(
                      onPressed: _finalize,
                      child: Text(finalizeBtn),
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
