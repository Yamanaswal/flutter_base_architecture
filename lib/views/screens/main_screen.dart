import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/lang/app_language.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                appLanguage.changeLanguage(const Locale("en"));
              });
            },
            child: Text('English'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                appLanguage.changeLanguage(const Locale("es"));
              });
            },
            child: Text('Arabic'),
          ),
          Text(AppLocalizations.of(context)?.appName ?? "")
        ],
      ),
    );
  }
}
