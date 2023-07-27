import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/human_resource/employee_master_model.dart';
Future<EmployeeMasterModel?> getEmployeeList(String vempName) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  var authToken = sharedPreferences.get("authToken");
  final msg = jsonEncode({"vemp_name": "$vempName"});
  var response = await http.post(
    Uri.parse("$url/hrc/getEmployeeList"),
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
    final dataModel = EmployeeMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}
