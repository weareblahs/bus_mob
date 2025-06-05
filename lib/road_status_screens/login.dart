import '../utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
  }

  Future<AuthResponse> _googleSignIn() async {
    final clientId = dotenv.env['GOOGLE_CLIENT_ID'];
    final signInOption = GoogleSignIn(serverClientId: clientId);
    final googleUser = await signInOption.signIn();
    if (googleUser == null) {}
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {}

    if (idToken == null) {}
    Hive.box("busConfig").put("dataChanged", true);
    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken!,
      accessToken: accessToken!,
    );
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
            SizedBox(height: 6),
            Text(
              signInPreText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton.icon(
              onPressed: _googleSignIn,
              label: Text(signInWithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
