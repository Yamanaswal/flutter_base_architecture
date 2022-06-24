import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/resources/lang/app_language.dart';
import 'package:flutter_base_architecture/views/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'view_models/providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Init Language.
  AppLanguage appLanguage = AppLanguage();
  var locale = await appLanguage.fetchLocale();

  runApp(
    MultiProvider(
      providers: providers,
      child:  MyApp(appLocale: locale),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key,required this.appLocale}) : super(key: key);
  final Locale appLocale;

  // This widget is the root of your application.
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
      locale: appLocale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      home: const SplashScreen(),
    );
  }
}
