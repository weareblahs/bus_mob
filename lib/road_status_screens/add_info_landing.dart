import '../utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddInfoSection extends StatefulWidget {
  const AddInfoSection({super.key, required this.redirect});
  final dynamic redirect;
  @override
  State<AddInfoSection> createState() => _AddInfoSectionState();
}

class _AddInfoSectionState extends State<AddInfoSection> {
  final supabase = Supabase.instance.client;
  void _signOut() async {
    Hive.box("busConfig").put("dataChanged", true);
    await supabase.auth.signOut();
    Hive.box("busConfig").put("dataChanged", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(roadStatusText, textAlign: TextAlign.center),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: widget.redirect,
                  child: Text("Submit info"),
                ),
                SizedBox(width: 20),
                ElevatedButton(onPressed: _signOut, child: Text("Sign out")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
