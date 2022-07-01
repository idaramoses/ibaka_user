import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onproperty/provider/auth_provider.dart';
import 'package:onproperty/provider/theme_provider.dart';
import 'package:onproperty/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'ibaka',
    options: FirebaseOptions(
      appId: '1:865558791864:android:7655a5ce386837d3e7164d',
      apiKey: 'AIzaSyAH5YHcWKxjVSg3gYS0aViMfjzMFVcP1P0',
      messagingSenderId: '865558791864',
      projectId: 'ibaka-da9f0',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SixAuthProvider()),
        ChangeNotifierProvider(create: (_) => SixThemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
