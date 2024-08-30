import 'package:crmelinnovadorseller/src/views/dashboard_view.dart';
import 'package:crmelinnovadorseller/src/views/home_view.dart';
import 'package:crmelinnovadorseller/src/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CRMelInnovadorSeller());
}

class CRMelInnovadorSeller extends StatefulWidget {
  const CRMelInnovadorSeller({super.key});

  @override
  State<CRMelInnovadorSeller> createState() => _CRMelInnovadorSellerState();
}

class _CRMelInnovadorSellerState extends State<CRMelInnovadorSeller> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomeView(),
        'register': (BuildContext context) => const RegisterView(),
        'DashboardView': (BuildContext context) => const DashboardView(),
      },
    );
  }
}
