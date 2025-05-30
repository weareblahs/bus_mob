import '../models/selection.dart';
import '../../utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

class SelectionItem extends StatefulWidget {
  const SelectionItem({super.key, required this.selection});
  final Selection selection;
  @override
  State<SelectionItem> createState() => _SelectionItemState();
}

class _SelectionItemState extends State<SelectionItem> {
  void confirmProcess() {
    String confirmationMsg = confirmRouteSelectionMessage;
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(confirm),
            content: Text(confirmationMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'selection_declined'),
                child: const Text(cancel),
              ),
              TextButton(
                onPressed: () {
                  final config = Hive.box("busConfig");
                  config.put("tempStoreRoute", widget.selection.value!);
                  context.pushReplacementNamed("selectStations");
                },
                child: const Text(confirmBtn),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: confirmProcess,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(widget.selection.label!),
        ),
      ),
    );
  }
}
