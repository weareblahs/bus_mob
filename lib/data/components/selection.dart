import 'package:bus_mob/data/models/selection.dart';
import 'package:flutter/material.dart';

class SelectionItem extends StatefulWidget {
  const SelectionItem({super.key, required this.selection});
  final Selection selection;
  @override
  State<SelectionItem> createState() => _SelectionItemState();
}

class _SelectionItemState extends State<SelectionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.selection.label);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(widget.selection.label!),
        ),
      ),
    );
  }
}
