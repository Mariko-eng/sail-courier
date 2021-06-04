import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sail_courier/AllWidgets/divider.dart';
import 'package:sail_courier/AppData/appData.dart';
import 'package:sail_courier/Assistants/requestAssistant.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController _newControllerGoogleMap;

  late Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0.347596, 32.582520),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName;
    pickUpTextEditingController.text = placeAddress;

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
                    style: TextStyle(fontSize: 15.0,
                        color: Colors.blue),
                  )
              ),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.person),
                  title:Text("Visit Profile",
                    style: TextStyle(fontSize: 15.0,
                        color: Colors.blue),
                  )
              ),
              SizedBox(height: 12.0,),
              ListTile(
                  leading: Icon(Icons.info),
                  title:Text("About",
                    style: TextStyle(fontSize: 15.0,
                        color: Colors.blue),
                  )
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              _newControllerGoogleMap = controller;

              setState(() {
                bottomPaddingOfMap =  265.0;
              });
              // locatePosition();
            },
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 5.0,
                        offset: Offset(0.7,0.7)
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 5.0),
               child: Column(
                children: [
                  SizedBox(height: 25.0,),
                  Expanded(
                    flex: 1,
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                      child: Padding(
                  padding: EdgeInsets.only(left: 0.0,right: 0.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5.0,),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.arrow_back),
                          ),
                          Center(
                            child: Text("Set Drop Off",
                              style: TextStyle(fontSize: 16.0,
                                color: Colors.blue,
                                fontFamily: "Brand-Bold"
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Image.asset("images/pickicon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(width: 18.0,),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: TextField(
                                    onChanged: (val){
                                      findPlace(val);
                                    },
                                    controller: pickUpTextEditingController,
                                    decoration: InputDecoration(
                                      hintText: "PickUp Location",
                                      fillColor: Colors.white,
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

                      SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Image.asset("images/desticon.png",
                            height: 16.0,
                            width: 16.0,
                          ),
                          SizedBox(width: 18.0,),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: TextField(
                                    onChanged: (val){
                                      findPlace(val);
                                    },
                                    controller: dropOffTextEditingController,
                                    decoration: InputDecoration(
                                        hintText: "Drop Off Location",
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
                                    ),
                                  ),
                                ),)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );


    // return Scaffold(
    //   body: Stack(
    //       children: [
    //         GoogleMap(
    //           padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
    //           mapType: MapType.normal,
    //           myLocationEnabled: true,
    //           myLocationButtonEnabled: true,
    //           initialCameraPosition: _kGooglePlex,
    //           zoomControlsEnabled: true,
    //           zoomGesturesEnabled: true,
    //           onMapCreated: (GoogleMapController controller){
    //             _controllerGoogleMap.complete(controller);
    //             _newControllerGoogleMap = controller;
    //
    //             setState(() {
    //               bottomPaddingOfMap =  265.0;
    //             });
    //             //locatePosition();
    //           },
    //         ),
    //         Positioned(
    //             top: 45.0,
    //             left: 22.0,
    //             child: Container(
    //               width: double.infinity,
    //               height: 100,
    //               color: Colors.blue,
    //             )
    //         )
    //       ],
    //     ),
    //     // child: Column(
    //     //   children: [
    //     //     SizedBox(height: 25.0,),
    //     //     Expanded(
    //     //       flex: 1,
    //     //       child: Container(
    //     //         decoration: BoxDecoration(
    //     //           color: Colors.white,
    //     //         ),
    //     //         child: Padding(
    //     //           padding: EdgeInsets.only(left: 25.0,right: 25.0),
    //     //           child: Column(
    //     //             children: [
    //     //               SizedBox(height: 5.0,),
    //     //               Stack(
    //     //                 children: [
    //     //                   GestureDetector(
    //     //                     onTap:(){
    //     //                       Navigator.pop(context);
    //     //                     },
    //     //                       child: Icon(Icons.arrow_back),
    //     //                   ),
    //     //                   Center(
    //     //                     child: Text("Set Drop Off",
    //     //                       style: TextStyle(fontSize: 16.0,
    //     //                         color: Colors.blue,
    //     //                         fontFamily: "Brand-Bold"
    //     //                       ),
    //     //                     ),
    //     //                   )
    //     //                 ],
    //     //               ),
    //     //               SizedBox(height: 10.0,),
    //     //               Row(
    //     //                 children: [
    //     //                   Image.asset("images/pickicon.png",
    //     //                     height: 16.0,
    //     //                     width: 16.0,
    //     //                   ),
    //     //                   SizedBox(width: 18.0,),
    //     //                   Expanded(
    //     //                       child: Container(
    //     //                         decoration: BoxDecoration(
    //     //                           color: Colors.blue,
    //     //                           borderRadius: BorderRadius.circular(5.0)
    //     //                         ),
    //     //                         child: Padding(
    //     //                           padding: EdgeInsets.all(3.0),
    //     //                           child: TextField(
    //     //                             onChanged: (val){
    //     //                               findPlace(val);
    //     //                             },
    //     //                             controller: pickUpTextEditingController,
    //     //                             decoration: InputDecoration(
    //     //                               hintText: "PickUp Location",
    //     //                               fillColor: Colors.white,
    //     //                               filled: true,
    //     //                               border: InputBorder.none,
    //     //                               isDense: true,
    //     //                               contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
    //     //                             ),
    //     //                           ),
    //     //                         ),
    //     //                       ),
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //               SizedBox(height: 10.0,),
    //     //               Row(
    //     //                 children: [
    //     //                   Image.asset("images/desticon.png",
    //     //                     height: 16.0,
    //     //                     width: 16.0,
    //     //                   ),
    //     //                   SizedBox(width: 18.0,),
    //     //                   Expanded(
    //     //                       child: Container(
    //     //                         decoration: BoxDecoration(
    //     //                             color: Colors.blue,
    //     //                             borderRadius: BorderRadius.circular(5.0)
    //     //                         ),
    //     //                         child: Padding(
    //     //                           padding: EdgeInsets.all(3.0),
    //     //                           child: TextField(
    //     //                             onChanged: (val){
    //     //                               findPlace(val);
    //     //                             },
    //     //                             controller: dropOffTextEditingController,
    //     //                             decoration: InputDecoration(
    //     //                                 hintText: "Drop Off Location",
    //     //                                 fillColor: Colors.white,
    //     //                                 filled: true,
    //     //                                 border: InputBorder.none,
    //     //                                 isDense: true,
    //     //                                 contentPadding: EdgeInsets.only(left: 11.0,top: 8.0,bottom: 8.0)
    //     //                             ),
    //     //                           ),
    //     //                         ),)
    //     //                   ),
    //     //                 ],
    //     //               ),
    //     //               SizedBox(height: 10.0,)
    //     //             ],
    //     //           ),
    //     //         ),
    //     //       ),
    //     //     ),
    //     //     Expanded(
    //     //       flex: 3,
    //     //         child:
    //     //         Container(
    //     //           color: Colors.blue,
    //     //           width: double.infinity,
    //     //           height: 200.0,
    //     //         ))
    //     //
    //     //   ],
    //     // ),
    // );
  }

  void findPlace(String placeName) async{
    String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${placeName}&key=AIzaSyCNFdAHxDMWSfckH4MUjqmQFRXRJOK2y8E&sessiontoken=1234567890&components=country:ug";

    var res = await RequestAssistant.getRequest(autoCompleteUrl);

    print(inspect(res));
  }

}
