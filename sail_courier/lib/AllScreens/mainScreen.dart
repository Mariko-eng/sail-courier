import 'dart:async';
import 'dart:developer';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sail_courier/AllScreens/searchScreen.dart';
import 'package:sail_courier/AllWidgets/divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sail_courier/AppData/appData.dart';
import 'package:sail_courier/Assistants/assistantMethods.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen ="main";
  final String item;
  MainScreen(this.item);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController _newControllerGoogleMap;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Permissions Disabled");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permissions Disabled");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLngPosition);
    _newControllerGoogleMap.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }

  void locatePosition() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    print("Positions");
    print(position.latitude);
    print(position.longitude);

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLngPosition);
    _newControllerGoogleMap.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    print(inspect(position));

    String address = await AssistantMethods.searchCoordinateAddress(position,context);

    print(address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0.347596, 32.582520),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              locatePosition();
            },
          ),

          //Hamburger button for Drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
                scaffoldKey.currentState!.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 6.0,
                      offset: Offset(
                        0.7,
                        0.7
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu,color: Colors.blue,),
                  radius: 20.0,
                ),
              ),
            ),
          ),


          Positioned(
            left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 180.0,
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
                  padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0,),
                      Text("Hi there, ",
                          style:TextStyle(fontSize: 15.0)),
                      Text("You want to deliver an item to??",
                          style:TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold")),
                      SizedBox(height:5.0 ,),
                      DividerWidget(),
                      SizedBox(height: 10.0,),
                      Container(
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
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Provider.of<AppData>(context).pickUpLocation != null ?
                                  Container(
                                    child: Text("Pick Up Location : " + Provider.of<AppData>(context).pickUpLocation.placeName),
                                  ):
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(width: 10.0,),
                                          Icon(Icons.search,color:Colors.blue),
                                          Text("Search For Pickup Location")
                                        ],
                                      ),
                                    )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0,),
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
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Icon(Icons.search,color:Colors.blue),
                                SizedBox(width: 10.0,),
                                Text("Search Drop Off Location")
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0,),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
