import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

Future<LatLng> getPositionFromIp() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list();
  LatLng position;

  for (var interface in await NetworkInterface.list()) {
    print('== Interface: ${interface.name} ==');
    if (position != null) {
      break;
    }
    for (var addr in interface.addresses) {
      print('${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      position = await getLatLng(addr.address);
      if (position != null) {
        break;
      }
    }
  }
  return position;
}

Future<LatLng> getLatLng(String ipAddress) async {
  if (ipAddress == null) {
    return null;
  }

  try {
    //   ipAddress = "200.114.207.244";
    String url = "http://api.ipstack.com/$ipAddress?access_key=ad1e416c08f9bf93f65fb63b121151e0&format=1";
    http.Response response = await http.get(url);

    if (response != null && response.statusCode == 200) {
      var r = response.body;
      if (response.body != null) {
        var data = json.decode(response.body);
        var resp = GetMyLocation.fromJson(json: data);
        return resp != null ? resp.latLng : null;
      }
    }
    // print(response.body.oString());
    return null;
  } catch (error) {
    return null;
  }
  // return postFromJson(response.body);
}

class GetMyLocation {
  final String ip;
  final LatLng latLng;

  GetMyLocation({this.ip, this.latLng});

  static GetMyLocation fromJson({Map<String, dynamic> json}) {
    try {
      return GetMyLocation(
        ip: json["ip"] as String,
        latLng: LatLng(json["latitude"], json["longitude"]),
        //latitude: json["latitude"] as double,
        //longitude: json["longitude"] as double,
      );
    } catch (error) {
      return null;
    }
  }
}

//https://ipstack.com/quickstart
/*
{
  "ip":"200.114.207.244",
  "type":"ipv4",
  "continent_code":"SA",
  "continent_name":"South America",
  "country_code":"AR",
  "country_name":"Argentina",
  "region_code":"B",
  "region_name":"Buenos Aires",
  "city":"San Isidro",
  "zip":"1642",
  "latitude":-34.4708,
  "longitude":-58.5286,
  "location":{
    "geoname_id":3428992,
    "capital":"Buenos Aires",
    "languages":[
      {
        "code":"es",
        "name":"Spanish",
        "native":"Espa\u00f1ol"
      },
      {
        "code":"gn",
        "name":"Guarani",
        "native":"Ava\u00f1e\u1ebd"
      }
    ],
    "country_flag":"http:\/\/assets.ipstack.com\/flags\/ar.svg",
    "country_flag_emoji":"\ud83c\udde6\ud83c\uddf7",
    "country_flag_emoji_unicode":"U+1F1E6 U+1F1F7",
    "calling_code":"54",
    "is_eu":false
  }
}
 */
