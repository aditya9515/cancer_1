import 'package:cancer/aditya/login_screen.dart';
import 'package:cancer/aditya/pone_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhoneProvider(),
      child: MaterialApp(
        
        title: 'ERAS', // Set your app title
        theme: ThemeData(
          primarySwatch: Colors.orange, 
        ),
        
        home:  LoginPage(), 
        debugShowCheckedModeBanner: false
      ),
    );
  }
}
