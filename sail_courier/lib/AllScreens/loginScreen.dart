import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sail_courier/AllScreens/registrationScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sail_courier/AllScreens/mainScreen.dart';
import 'package:sail_courier/AllWidgets/progressBar.dart';

class LoginScreen  extends StatelessWidget {
  static const String idScreen ="login";
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // For smaller screens to enable the user to scroll on phones with smaller screen
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              Image(image: AssetImage("images/SailCourier_logo.png"),
                width: 350.0,
                height: 350.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 15.0,),
              Text(
                "Login as a Rider",
                style: TextStyle(
                  fontSize: 24.0,fontFamily: "Brand-Bold",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.0,),
              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                     TextField(
                       controller: emailTextEditController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         labelText: "Email",
                         labelStyle: TextStyle(
                           fontSize: 14.0
                         ),
                         hintStyle: TextStyle(
                           color: Colors.grey,
                           fontSize: 10.0
                         )
                       ),
                     ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditController,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                              fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0
                          )
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    RaisedButton(
                      onPressed: (){
                        if(!emailTextEditController.text.contains("@")){
                          dispalyToastSms(context, "Wrong Email!!!");
                        }else if(passwordTextEditController.text.length < 7){
                          dispalyToastSms(context, "Wrong Password!!!");
                        }else{
                          loginUser(context);
                        }
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text("Login",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Brand-Bold"
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                  },
                  child: Text(
                    "Do not have an Account? Register Here."
                  ))
            ],
          ),
        ),
      ),
    );
  }

  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");
  FirebaseAuth _auth = FirebaseAuth.instance;
  loginUser(BuildContext context) async{

    showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return ProgressBar("Authenticating, Please Wait");
        });

    try{
      UserCredential authResult = (await _auth.signInWithEmailAndPassword(
          email: emailTextEditController.text,
          password: passwordTextEditController.text));
      if(authResult.user != null){
        usersRef.child(authResult.user!.uid).once().then((DataSnapshot snap){
          if(snap.value != null){
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
            dispalyToastSms(context, "Login Successful");
          }else{
            Navigator.pop(context);
            dispalyToastSms(context, "Login Falied");
          }
        });
      }else{
        Navigator.pop(context);
        _auth.signOut();
        dispalyToastSms(context, "No record found for this user, Created new account");
      }
    }catch(error){
      Navigator.pop(context);
      dispalyToastSms(context,"Errpr :" + error.toString());
    }
  }

  dispalyToastSms(BuildContext context,String message){
    Fluttertoast.showToast(msg: message);
  }
}
