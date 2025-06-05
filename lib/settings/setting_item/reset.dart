import 'package:flutter/material.dart';
import '../../utils/variables.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restart_app/restart_app.dart';

class ResetAppSettings extends StatefulWidget {
  const ResetAppSettings({super.key});

  @override
  State<ResetAppSettings> createState() => _ResetAppSettingsState();
}

class _ResetAppSettingsState extends State<ResetAppSettings> {
  void resetDataProcess() {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(confirm),
            content: Text(resetDataConfirmationMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'selection_declined'),
                child: const Text(cancel),
              ),
              TextButton(
                onPressed: () {
                  final config = Hive.box("busConfig");
                  config.clear();
                  Restart.restartApp();
                },
                child: const Text(resetData),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              resetData,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(resetDataMessage),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
              ),
              onPressed: resetDataProcess,
              child: const Text(resetData),
            ),
          ],
        ),
      ),
    );
  }
}
