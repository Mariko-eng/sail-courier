import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_courier/AllScreens/itemsScreen.dart';
import 'package:sail_courier/AllScreens/loginScreen.dart';
import 'package:sail_courier/AllScreens/parcelScreen.dart';
import 'package:sail_courier/AllScreens/registrationScreen.dart';
import 'package:sail_courier/AppData/appData.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
// Can be accessed by all the pages.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Sail Courier',
        theme: ThemeData(
          fontFamily: "Brand-Bold",
          primarySwatch: Colors.blue,
        ),
        initialRoute: ParcelScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          ParcelScreen.idScreen: (context) => ParcelScreen(),
          ItemsScreen.idScreen: (context) => ItemsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

