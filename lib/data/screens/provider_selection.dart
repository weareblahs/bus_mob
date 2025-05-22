import 'package:bus_mob/data/components/provider_selection_button.dart';
import 'package:bus_mob/data/models/providers.dart';
import 'package:bus_mob/utils/provider_selection.dart';
import 'package:flutter/material.dart';

class ProviderSelectionScreen extends StatefulWidget {
  const ProviderSelectionScreen({super.key});

  @override
  State<ProviderSelectionScreen> createState() =>
      _ProviderSelectionScreenState();
}

class _ProviderSelectionScreenState extends State<ProviderSelectionScreen> {
  List<Providers> listOfProviders = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final providers = await getProviders();
    setState(() {
      listOfProviders = providers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: Column(
          children: [
            Text(
              "Welcome to bus?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0),
            ),
            Text(
              "To start, select a bus provider below.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            Expanded(
              child: SafeArea(
                child: ListView.builder(
                  itemCount: listOfProviders.length,
                  itemBuilder:
                      (context, index) => ProviderSelectionButton(
                        providerInfo: listOfProviders[index],
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
