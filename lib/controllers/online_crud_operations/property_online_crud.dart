import 'dart:convert';
import 'package:crm/models/property/property_units_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/crm/investor_detail_model.dart';
import '../../models/property/property_master_model.dart';

Future<PropertyMasterModel?> getPropertyList(String vpropertyName) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  print(url);
  final msg = jsonEncode(
      {"vproperty_name": "$vpropertyName", "vemp_code": "$vempCode"});
  var response = await http.post(
    Uri.parse("$url/prmc/getPropertyMasterList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Property type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = PropertyMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<PropertyUnitsModel?> getUnitList(int ipropertyId,String ccurrent_status) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  print(url);
  final msg = jsonEncode({"iproperty_id": ipropertyId, "ccurrent_status": "$ccurrent_status"});
  var response = await http.post(
    Uri.parse("$url/prmc/getUnitsAndStatusList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Property type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = PropertyUnitsModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}


Future<InvestorDetailModel?> getUnitsPerInvestorList(int iproperty_id,String vcustomer_code) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  print(url);
  final msg = jsonEncode({"iproperty_id": iproperty_id, "vcustomer_code": "$vcustomer_code"});
  var response = await http.post(
    Uri.parse("$url/crmc/getUnitsPerCustomerList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Property type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = InvestorDetailModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}
