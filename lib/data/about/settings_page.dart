import 'package:bus_mob/data/about/setting_item/about_app.dart';
import 'package:bus_mob/data/about/setting_item/reset.dart';
import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ResetAppSettings(),
              AboutApp(),
              // license
            ],
          ),
        ),
      ),
    );
  }
}
