import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/resources/lang/app_language.dart';
import 'package:flutter_base_architecture/view_models/provider_view_models/post_view_model.dart';
import 'package:library_store/library_store.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var vm = Provider.of<PostViewModel>(context, listen: false);

    vm.callApiPosts().then((value) {
      print("DATA::::");
      print(value);
    });

    vm.callApi().then((value) {
      print("DATA POST 1 ::::");
      print(jsonEncode(value));
    });
    var s = SocketManager();
    s.init();
  }

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
                  MyApp.of(context)?.setLocale(const Locale("en"));
                });
              },
              child: Text('English' ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  appLanguage.changeLanguage(const Locale("es"));
                  MyApp.of(context)?.setLocale(const Locale("es"));
                });
              },
              child: Text('Arabic '),
            ),
            Text(AppLocalizations.of(context)?.appName ?? "" ),
            Text(AppLocalizations.of(context)?.version ?? "" ),
            Text(AppLocalizations.of(context)?.sdkVersion ?? "" )
          ],
        ),
    );
  }


}
