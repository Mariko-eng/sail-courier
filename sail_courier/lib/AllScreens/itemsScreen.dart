import 'package:flutter/material.dart';
import 'package:sail_courier/AllModels/itemsModel.dart';
import 'package:sail_courier/AllScreens/mainScreen.dart';
import 'package:sail_courier/AllWidgets/divider.dart';


class ItemsScreen extends StatefulWidget {
  static const String idScreen ="items";


  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<MenuItem> menuItems = [
    MenuItem(title: 'Electronics', icon: Icons.computer_sharp, id: "electronics"),
    MenuItem(title: 'Food/Snacks', icon: Icons.fastfood_rounded, id: "food"),
    MenuItem(title: 'Envelopes', icon: Icons.tab_outlined, id: "envelopes"),
    MenuItem(title: 'Fashion', icon: Icons.landscape_outlined, id: "fashion"),
    MenuItem(title: 'Money', icon: Icons.money_off, id: "money"),
    MenuItem(title: 'Others', icon: Icons.grading_outlined, id: "others"),
  ];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: 100.0,
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.menu,
                        color:Colors.blue
                    ),
                      onPressed: (){
                        // Scaffold.of(context).openDrawer();
                        scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          "Select Item To Deliver...",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: menuItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainScreen(menuItems[index].id))
                          );
                        },
                        child: Card(
                          elevation: 20.0,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(menuItems[index].icon,
                                  color: Colors.white,
                                  size: 65,
                                ),
                                Text(menuItems[index].title,
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 20.0,
                                      fontStyle: FontStyle.italic
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
