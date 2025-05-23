import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // settings
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ),
            // license
            Text(licenseText, textAlign: TextAlign.start),
            Center(
              child: ElevatedButton(
                child: Text('Show Licenses'),
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (BuildContext context) => AboutDialog(
                            applicationLegalese: legalText,
                            applicationName: 'bus?',
                            applicationVersion: '1.0',
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
