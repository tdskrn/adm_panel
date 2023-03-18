import 'package:adm_panel/firebase_options.dart';
import 'package:adm_panel/utils/colors/colors_marques.dart';
import 'package:adm_panel/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: ColorsMarques.blueMarques,
          secondary: ColorsMarques.orangeMarques,
        ),
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
