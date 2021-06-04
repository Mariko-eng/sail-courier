
import 'package:flutter/cupertino.dart';
import 'package:sail_courier/Models/address.dart';

class AppData extends ChangeNotifier{
  Address pickUpLocation = Address(32.58, 0.3,"SGC Kampala");

  void updatePickupLocationAddress(Address pickupAddress){
    pickUpLocation = pickupAddress;
    notifyListeners();
  }

}