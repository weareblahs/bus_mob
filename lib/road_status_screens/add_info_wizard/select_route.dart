import '../../components/selection.dart';
import '../../models/selection.dart';
import '../../utils/convert_providers.dart';
import '../../utils/variables.dart';
import 'package:flutter/material.dart';

class SelectRouteScreen extends StatefulWidget {
  const SelectRouteScreen({super.key});

  @override
  State<SelectRouteScreen> createState() => _SelectRouteScreenState();
}

class _SelectRouteScreenState extends State<SelectRouteScreen> {
  List<Selection> routes = [];

  @override
  void initState() {
    setState(() {
      routes = selectionCardRoutes();
    });
    super.initState();
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
                children: [Text(selectARoute, style: TextStyle(fontSize: 28))],
              ),
            ),
            Expanded(
              flex: 9,
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                itemCount: routes.length,
                itemBuilder:
                    (context, index) => SelectionItem(selection: routes[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
