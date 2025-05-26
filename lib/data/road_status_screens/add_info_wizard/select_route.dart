import 'package:bus_mob/data/components/selection.dart';
import 'package:bus_mob/data/models/selection.dart';
import 'package:bus_mob/utils/convert_providers.dart';
import 'package:bus_mob/utils/variables.dart';
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
        padding: const EdgeInsets.all(32.0),
        child: ListView.builder(
          itemCount: routes.length,
          itemBuilder:
              (context, index) => SelectionItem(selection: routes[index]),
        ),
      ),
    );
  }
}
