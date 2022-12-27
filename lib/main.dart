import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepnote/view/createNote.dart';
import 'package:keepnote/view/homeScreen.dart';
import 'package:keepnote/view/splashScreen.dart';

void main()async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>SplashScreen(),
        '/home':(context)=>HomeScreen(),
        '/note':(context)=>CreateNote(),
      },
    ),
  );
}