import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Home/menu_model.dart';
import '../../models/user_management/city_model.dart';
import '../../models/user_management/country_model.dart';

Future<MenuModel?> login(String vlogin_name, String vpassword) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  print(url);
  final msg = jsonEncode({"vlogin_name": vlogin_name, "vpassword": vpassword,"source_id":27});
  var response = await http.post(Uri.parse("$url/umc/authLogin"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: msg);
  print(vlogin_name);
  print(vpassword);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = MenuModel.fromJson(jsonDecode(responseString));
    return dataModel;
  } else {
    return null;
  }
}
Future<CityModel?> getCityList(String vcityName) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({
    "cityName": "$vcityName",
  });
  var response = await http.post(
    Uri.parse("$url/umc/getCityList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Payment type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = CityModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}
Future<CountryModel?> getCountryList(String vcountryName) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({
    "countryName": "$vcountryName",
  });
  var response = await http.post(
    Uri.parse("$url/umc/getCountryList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Payment type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = CountryModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}