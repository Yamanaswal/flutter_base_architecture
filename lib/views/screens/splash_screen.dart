import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/view_models/provider_models/post_view_model.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';


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
    vm.callApi();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
            },
            child: Text('Go To Main Screen'),
          ),
        ],
      ),
    );
  }
}
