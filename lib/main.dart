import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/models/database/database.dart';
import 'package:flutter_base_architecture/utils/log.dart';
import 'package:flutter_base_architecture/views/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/database/database_utils.dart';
import 'view_models/providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /** Init Database - Hive. **/
  await Hive.initFlutter();

  /** Create Boxes - Tables **/
  await createTables();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      home: const SplashScreen(),
    );
  }

  var locale = const Locale("en");

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }
}
