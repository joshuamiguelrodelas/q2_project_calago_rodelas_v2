import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/main_navigation.dart';
import 'screens/login_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
 await dotenv.load(fileName: 'assets/.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(const EInfoHubApp());
}

class EInfoHubApp extends StatelessWidget {
  const EInfoHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-nfo Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6B7A3C),
        scaffoldBackgroundColor: const Color(0xFFFFFDF6),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF6B7A3C),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return const MainNavigation();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
