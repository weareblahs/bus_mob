import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

List<DropdownMenuEntry> dropdownProviders() {
  List<DropdownMenuEntry> providers = [];
  var config = Hive.box("busConfig");
  var providersUnformatted = config.get("providerRoutes");
  var decodedProviders = json.decode(providersUnformatted);
  for (final p in decodedProviders) {
    var display = "";
    if ("${p['id']}".endsWith("A")) {
      display = "${p['id'].substring(0, p['id'].length - 1)}▶";
    }
    if ("${p['id']}".endsWith("B")) {
      display = "${p['id'].substring(0, p['id'].length - 1)}◀";
    }
    providers.add(
      DropdownMenuEntry(value: p['id'], label: "$display ${p['name']}"),
    );
  }
  return providers;
}
