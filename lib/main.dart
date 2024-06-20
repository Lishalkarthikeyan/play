
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicplay/view/forgotpassword.dart';
import 'package:musicplay/view/homepage.dart';
import 'package:musicplay/view/loginpage.dart';
import 'package:musicplay/view/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SizedBox(
      width: width,
      height: height,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "registerpage": (context) => RegisterPage(),
        "loginpage": (context) => loginpage(),
        "forgotpass": (context) => forgotpass(),
        "homepages": (context) => Homepage(),

      },
      title: 'PlayMusic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: (width = width),
                height: (height = height),
                color: Colors.black,
                child: AnimatedSplashScreen(
                  nextScreen: isLoggedIn ?? false ? Homepage() : loginpage(),
                  splash:
                      Text(
                        "Play Music",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),

                  backgroundColor: Colors.black,
                  duration: 3,
                  splashTransition: SplashTransition.fadeTransition,
                ),
              ),
            ],
          )),
    );
  }
}