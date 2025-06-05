import '../components/provider_selection_button.dart';
import '../models/providers.dart';
import '../utils/provider_selection.dart';
import '../utils/variables.dart';
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
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 36, 0, 36),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  welcome,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32.0),
                ),
                Text(
                  landingWelcomeMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                if (listOfProviders.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    ),
                  ),
                if (listOfProviders.isNotEmpty)
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
        ),
      ),
    );
  }
}
