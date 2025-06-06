import 'package:bus_mob/settings/setting_item/about_app.dart';
import 'package:bus_mob/settings/setting_item/reset.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
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
