import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sail_courier/AllScreens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sail_courier/AllScreens/mainScreen.dart';
import 'package:sail_courier/AllWidgets/progressBar.dart';
import 'package:sail_courier/main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen ="register";

  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController phoneTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // For smaller screens to enable the user to scroll on phones with smaller screen
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Image(image: AssetImage("images/SailCourier_logo.png"),
                width: 350.0,
                height: 350.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 15.0,),
              Text(
                "Register as a Rider",
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
                      controller: nameTextEditController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Name",
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
                      controller: phoneTextEditController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Phone",
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
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditController,
                      obscureText: true,
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
                        if(nameTextEditController.text.length < 4){
                          displayToastSms(context, "Name must be atleast 4 charaters");
                        }else if(!emailTextEditController.text.contains("@")){
                          displayToastSms(context, "Wrong Email Format");
                        }else if(passwordTextEditController.text.isEmpty){
                          displayToastSms(context, "Input Password");
                        }else if(phoneTextEditController.text.length < 7){
                          displayToastSms(context, "Wrong Phone Number");
                        }else{
                          registerNewUser(context);
                        }
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text("Create Account",
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
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                  },
                  child: Text(
                      "Already having an Account? Login Here."
                  ))
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  registerNewUser(BuildContext context) async{
    showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return ProgressBar("Registering, Please Wait");
        });
    try{
      UserCredential authResult = (await _auth.createUserWithEmailAndPassword(
          email: emailTextEditController.text,
          password: passwordTextEditController.text));
      if(authResult.user != null){
        Map userDataMap = {
          "name" : nameTextEditController.text.trim(),
          "email" : emailTextEditController.text.trim(),
          "phone" : phoneTextEditController.text.trim()
        };
        Navigator.pop(context);
        usersRef.child((authResult.user!.uid)).set(userDataMap);
        displayToastSms(context, "Registration Successful");
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }else{
        Navigator.pop(context);
        displayToastSms(context, "Registration Failure");
      }
    }catch(error){
      Navigator.pop(context);
      displayToastSms(context,"Errpr :" + error.toString());
    }
  }
  
  displayToastSms(BuildContext context,String message){
    Fluttertoast.showToast(msg: message);
  }
}
