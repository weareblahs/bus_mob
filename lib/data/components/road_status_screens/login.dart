import 'package:bus_mob/utils/variables.dart';
import 'package:flutter/material.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
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
            Text(
              signInPreText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            ElevatedButton.icon(
              onPressed: () {
                print("Button pressed");
              },
              label: Text(signInWithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
