import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:sail_courier/Models/address.dart';
import 'requestAssistant.dart';
import 'package:provider/provider.dart';
import 'package:sail_courier/AppData/appData.dart';


class AssistantMethods{
  static Future<String> searchCoordinateAddress(Position position,context) async{
    String placeAddress = "";
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCNFdAHxDMWSfckH4MUjqmQFRXRJOK2y8E";

    var response = await RequestAssistant.getRequest(url);

    //print(inspect(response));

    if(response != null){
      placeAddress = response["results"][0]["formatted_address"];

      Address userPickupAddress = new Address(
        position.latitude,
        position.longitude,
        placeAddress
      );
      Provider.of<AppData>(context,listen: false).updatePickupLocationAddress(userPickupAddress);
    }else {
      placeAddress = "failed";
    }

    if(response == "failed"){
      placeAddress = "failed";
    }

    return placeAddress;
  }
}