import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup',
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),

      body: Column(
        children: [

          TextField(
            decoration: const InputDecoration(
              labelText: "EMAIL",
            ),
            onChanged: (value) {
              email = value;
            },
          ),

          TextField(
            decoration: const InputDecoration(
              labelText: "PASSWORD",
            ),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),

          ElevatedButton(
            onPressed: () async {

              try {

                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Signup Successful"),
                  ),
                );

              } on FirebaseAuthException catch (e) {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Signup Failed: ${e.message}"),
                  ),
                );

              }

            },
            child: const Text("SIGN UP"),
          ),

        ],
      ),
    );
  }
}
