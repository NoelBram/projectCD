import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:bramblur/services/auth.dart';
import 'package:bramblur/components/home.dart';

import 'package:bramblur/firebase_options.dart';

/// Requires that a Firebase local emulator is running locally.
/// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = false;

// Requires that the Firebase Auth emulator is running locally
// e.g via `melos run firebase:emulator`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
  // See related issue: https://github.com/flutter/flutter/issues/96391
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'OpenSans',
    );
    final _colorizeColors = [
      Colors.black54,
      Colors.purpleAccent,
      Colors.purple,
      Colors.deepPurple,
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.deepPurpleAccent,
      Colors.blueAccent,
      Colors.blueAccent,
      Colors.blue,
      Colors.blue,
      Colors.lightBlue,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.lightBlueAccent,
      Colors.greenAccent,
      Colors.greenAccent,
      Colors.green,
      Colors.green,
      Colors.lightGreenAccent,
      Colors.lightGreenAccent,
      Colors.lime,
      Colors.lime,
      Colors.yellowAccent,
      Colors.yellowAccent,
      Colors.yellow,
      Colors.yellow,
      Colors.orangeAccent,
      Colors.orangeAccent,
      Colors.orange,
      Colors.orange,
      Colors.deepOrange,
      Colors.deepOrange,
      Colors.redAccent,
      Colors.redAccent,
      Colors.red,
      Colors.red,
    ];

    final logo = Container(
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Project CD',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            //FlickerAnimatedText('BLUR'),
          ],
        ));

    return MaterialApp(
      title: 'Project CD',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraines) {
            return Row(
              children: [
                Visibility(
                  visible: constraines.maxWidth >= 1200,
                  child: Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: logo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: constraines.maxWidth >= 1200
                      ? constraines.maxWidth / 2
                      : constraines.maxWidth,
                  child: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const Home();
                      }
                      return const AuthGate();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
