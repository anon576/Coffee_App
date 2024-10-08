import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/route.dart';
import '../components/share_prefs.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  bool isLoggedIn = false;


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getValidationData().whenComplete(() async {
      _timer = Timer(Duration(seconds: 3), () {
        if (isLoggedIn) {
         RouterClass.ReplaceScreen(context, "/home");
        } else {
             RouterClass.ReplaceScreen(context, "/startup");
        }
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  Future<void> getValidationData() async {
       
isLoggedIn =await  SharePrefs.readPrefs('isLogin','bool') ?? false;
    // sp.setBool('isLogin',false);
    setState(() {
      
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 5.0),
            child: Container(
              height: 300,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset( 
                "assets/logo.jpg"
              )
            ),
          ),
        ),
      
    );
  }
}