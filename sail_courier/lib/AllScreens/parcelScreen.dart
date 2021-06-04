import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sail_courier/AllScreens/searchScreen.dart';
import 'package:sail_courier/AllWidgets/divider.dart';

class ParcelScreen extends StatefulWidget {
  static const String idScreen ="parcel";

  @override
  _ParcelScreenState createState() => _ParcelScreenState();
}

class _ParcelScreenState extends State<ParcelScreen> {
  TextEditingController parcelTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.white,
        width: 355.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name",
                            style: TextStyle(fontSize: 25.0),
                          ),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile",)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.history),
                  title:Text("History",
                    style: TextStyle(fontSize: 25.0,
                        color: Colors.blue),
                  )
              ),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.person),
                  title:Text("Visit Profile",
                    style: TextStyle(fontSize: 25.0,
                        color: Colors.blue),
                  )
              ),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.info),
                  title:Text("About",
                    style: TextStyle(fontSize: 25.0,
                        color: Colors.blue),
                  )
              ),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.logout),
                  title:Text("Log Out",
                    style: TextStyle(fontSize: 25.0,
                        color: Colors.blue),
                  )
              )
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 5.0,),
                  Image(image: AssetImage("images/SailCourier_logo.png"),
                    width: 350.0,
                    height: 100.0,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 15.0,),
                  Container(
                    child: Text("Welcome to Sail Courier"),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    child: Text("Always Ready To Deliver Your Item AnyWhere"),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    child: Card(
                      elevation: 20.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 100.0,
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Icon(Icons.tab,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 18.0,),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: TextField(
                                        onChanged: (val){
                                        },
                                        controller: parcelTextEditingController,
                                        decoration: InputDecoration(
                                            hintText: "Enter Your Item To Be Delivered",
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100.0,
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Icon(Icons.line_weight_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 18.0,),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: TextField(
                                        onChanged: (val){
                                        },
                                        controller: weightTextEditingController,
                                        decoration: InputDecoration(
                                            hintText: "Weight of The Item in Kgs",
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("Charges in UgSHS",
                        style: TextStyle(color: Colors.blue,
                          fontFamily: "Brand-Regular", fontSize: 25.0
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      child: Card(
                        color: Colors.white,
                        elevation: 0.5,
                        child: Container(
                          child: Table(
                            children: <TableRow>[
                              TableRow(
                                  children: [
                                    TableCell(child: Text("Kilograms")),
                                    TableCell(child: Text("Prices"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("0.1 - 5.0")),
                                    TableCell(child: Text("5,000"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("5.1 - 10.0")),
                                    TableCell(child: Text("10,000"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("10.1 - 20.0")),
                                    TableCell(child: Text("20,000"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("20.1 - 40.0")),
                                    TableCell(child: Text("30,000"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("40.1 - 100.0")),
                                    TableCell(child: Text("50,000"))
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    TableCell(child: Text("100.0 ...")),
                                    TableCell(child: Text("100,000"))
                                  ]
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>SearchScreen())
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7,0.7),
                            )
                          ]
                      ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                          },
                          child: Container(
                            height: 80.0,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  Image.asset("images/pickicon.png",
                                    height: 16.0,
                                    width: 16.0,
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text("Choose Pick Up And Drop Off Location",
                                    style: TextStyle(color: Colors.white,
                                      fontSize: 17.0
                                    ),
                                  )
                                ],
                              ),
                            ),
                      ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
