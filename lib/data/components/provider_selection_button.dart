import 'package:bus_mob/data/models/providers.dart';
import 'package:bus_mob/utils/download_provider_to_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

class ProviderSelectionButton extends StatefulWidget {
  const ProviderSelectionButton({super.key, required this.providerInfo});

  final Providers providerInfo;

  @override
  State<ProviderSelectionButton> createState() =>
      _ProviderSelectionButtonState();
}

class _ProviderSelectionButtonState extends State<ProviderSelectionButton> {
  void selectAndUpdate(String provider, String providerURL) {
    final config = Hive.box('busConfig');
    config.put("provider", provider);
    config.put("providerEndpointURL", providerURL);
    downloadProvider();
    context.pushNamed("home");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            showDialog<String>(
              context: context,
              builder:
                  (BuildContext context) => AlertDialog(
                    title: const Text('Confirm selection'),
                    content: Text(
                      "You selected ${widget.providerInfo.providerName}. When you press Yes, it will show ${widget.providerInfo.providerName} buses by default when you start the app. You can change it at the Settings tab. The app will restart. Do you want to continue?",
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed:
                            () => Navigator.pop(context, 'selection_declined'),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed:
                            () => selectAndUpdate(
                              widget.providerInfo.providerName!,
                              widget.providerInfo.endpoint!,
                            ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: Icon(Icons.bus_alert)),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.providerInfo.providerName!,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "${widget.providerInfo.state!}, ${widget.providerInfo.country!}",
                        textAlign: TextAlign.left,
                      ),
                    ],
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
