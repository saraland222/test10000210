import 'package:appboy/Screen/mainScreen.dart';
import 'package:appboy/providers/auth_provider.dart';
import 'package:appboy/providers/location_provider.dart';
import 'package:appboy/providers/store_provider.dart';
import 'package:appboy/welcomeScreen.dart';
import 'package:appboy/widget/customAppBarScroller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomePage/HomeScreen.dart';
import 'Screen/landing_screen.dart';
import 'Screen/login_screen.dart';
import 'Screen/map_screen.dart';
import 'Screen/splash_screen.dart';
import 'Screen/vendor_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => StoreProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),


      initialRoute: SplashScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        MapScreen.id: (context) => MapScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        VendorHomeScreen.id: (context) => VendorHomeScreen(),
        MainScreen.id: (context) => MainScreen(),
        CustomAppBarScroller.id: (context) => CustomAppBarScroller(),
      },
    );
  }
}
