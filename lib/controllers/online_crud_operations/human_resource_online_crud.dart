import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/human_resource/employee_master_model.dart';
import '../../models/human_resource/leave_request_master_model.dart';
import '../../models/human_resource/leave_type_category_model.dart';
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
Future<int?> addLeaveRequestDetail(LeaveRequestMasterModel data) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  LeaveRequestMasterModel model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print(dcreatedDate);
  print(data.id);
  final msg = jsonEncode({
    "id": "${data.ileaveRequestDetailId}",
    "vleave_request_code": "${data.vleaveRequestCode}",
    "dleave_date": "${data.ddate}",
    "ileave_count_type": "${data.ileaveCountType}",
    "mleave_count": "${data.mleaveCount}",
    "ileave_type": "${data.ileaveType}",
    "cstatus": "A",
    "vcreated_by": "$vempCode",
    "vupdated_by": "$dcreatedDate"
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addEnquiryGenerationMaster"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    model = LeaveRequestMasterModel.fromJson(jsonDecode(responseString));
    int? id = model.ileaveRequestDetailId;
    return id;
  }
}
Future<String?> addLeaveRequestMaster(LeaveRequestMasterModel data) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  LeaveRequestMasterModel? model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var dcreatedDate = DateTime.now();
  print("Leave Master");
  final msg = jsonEncode({
    "id":"",
    "capproved_status":"A",
    "cstatus":"A",
    "ddate":"${data.ddate}",
    "ibusiness_area_id":"${data.ibusinessAreaId}",
    "vbusiness_area_short_name":"PD",
    "vcreated_by":"$vempCode",
    "vemp_code":"${data.vhandoverEmpCode}",
    "vhandover_emp_code":"${data.vhandoverEmpCode}",
    "vhandover_emp_code_to":"${data.vhandoverEmpCodeTo}",
    "vleave_request_code":"${data.vleaveRequestCode}",
    "vreason":"${data.vreason}",
    "vreference_no":"${data.vreferenceNo}",
    "vupdated_by":"${data.vupdatedBy}"

  });
  var response = await http.post(
    Uri.parse("$url/crmc/addNewActivityCustomer"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String responseString = response.body;
    model = LeaveRequestMasterModel.fromJson(jsonDecode(responseString));
    print(model.vleaveRequestCode);
    return model.vleaveRequestCode;
  }
}
Future<LeaveTypeCategoryModel?> getLeaveCategoryTypeList(String vleaveCategoryName) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  print(url);
  final msg = jsonEncode(
      {});
  var response = await http.post(
    Uri.parse("$url/hrc/getLeaveTypeCategorylist"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========Category Type List=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = LeaveTypeCategoryModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

