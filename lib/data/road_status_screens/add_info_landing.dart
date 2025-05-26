import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddInfoSection extends StatefulWidget {
  const AddInfoSection({super.key});

  @override
  State<AddInfoSection> createState() => _AddInfoSectionState();
}

class _AddInfoSectionState extends State<AddInfoSection> {
  final supabase = Supabase.instance.client;
  void _signOut() async {
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Add info"),
          ElevatedButton(onPressed: _signOut, child: const Text("Log out")),
        ],
      ),
    );
  }
}
