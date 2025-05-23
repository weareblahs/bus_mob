import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(licenseText, textAlign: TextAlign.start),
        Center(
          child: ElevatedButton(
            child: Text(showLicensesBtn),
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
    );
  }
}
