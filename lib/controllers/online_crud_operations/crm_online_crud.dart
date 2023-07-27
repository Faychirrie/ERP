import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:crm/models/crm/fire_base_token_model.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:phone_state/phone_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/DateUtility/date_utils.dart';
import '../../models/crm/billboard_master_model.dart';
import '../../models/crm/call_Log_data_model.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import '../../models/crm/customer_visit_note_master_model.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import '../../models/crm/enquiry_source_model.dart';
import '../../models/crm/lead_qualification_master_model.dart';
import '../../models/crm/payment_terms_master_model.dart';
import '../../models/crm/property_booking_agent_model.dart';

Future<String?> addNewActivityCustomer(EnquiryList data) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  EnquiryGenerationMasterModel? model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var dcreatedDate = DateTime.now();
  print("new acctivity");
  print(data.vcustomerMobile);
  final msg = jsonEncode({
    "id": data.inac_id,
    "vplant_name": "${data.vcustomerName}",
    "vplant_code": "${data.vtempCustomerCode}",
    "vcustomer_plant_address": "${data.vcustomerAddress}",
    "vcustomer_plant_country": "",
    "vpermanent_state": "",
    "vcustomer_tahsil": "",
    "vcustomer_plant_pincode": "",
    "vpermanent_city": "",
    "vregion": "",
    "vcustomer_fax": "",
    "vcustomer_plant_email": "${data.vcustomerEmailAddress}",
    "vcustomer_plant_contactperson1": "",
    "vcontact_person1_des": "",
    "vcustomer_plant_contactperson2": "",
    "vcontact_person2_des": "",
    "vcustomer_plant_ph1": "",
    "vcustomer_plant_ph2": "",
    "vcustomer_plant_website": "",
    "vcustomer_type": "",
    "vclient_created": "",
    "vtime_in": "",
    "vtime_out": "",
    "cstatus": "A",
    "cTax_type": "A",
    "icity_id": "${data.cityId}",
    "icurrency_id": 1,
    "vtin_no": "${data.vtax_no}",
    "voffice_contact_no": "",
    "vmarketing_engineer_code": "",
    "vcreated_by": "",
    "dcreated_date": "",
    "vupdated_by": "",
    "dupdated_date": "",
    "vcustomer_plant_mob1": "${data.vcustomerMobile1}",
    "vcustomer_plant_mob2": "${data.vcustomerMobile2}",
    "icompany_id": 1,
    "vcompany_short_name": "",
    "vuser_plant_code": "",
    "ibusiness_area_id": 1,
    "vbusiness_area_short_code": "PD"
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
    model = EnquiryGenerationMasterModel.fromJson(jsonDecode(responseString));
    print(model.vtransactionCode);
    return model.vtransactionCode;
  }
}

addFirebaseToken(int id) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var fcmToken = sharedPreferences.get("fcmToken");
  final msg = jsonEncode({
    "id": "$id",
    "vemp_code": "$vempCode",
    "vtoken": "$fcmToken",
    "cstatus": "A"
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addFireBaseToken"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String responseString = response.body;
  }
}

Future<int?> addEnquiry(EnquiryList data) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  EnquiryGenerationMasterModel model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print(dcreatedDate);
  print(data.vcustomerMobile);
  print(data.id);
  final msg = jsonEncode({
    "id": "${data.id}",
    "vcustomer_name": "${data.vcustomerName}",
    "vcustomer_address": "${data.vcustomerAddress}",
    "vcustomer_mobile1": "${data.vcustomerMobile1}",
    "vcustomer_mobile2": "${data.vcustomerMobile2}",
    "vcustomer_email_address": "${data.vcustomerEmailAddress}",
    "vcustomer_email_address2": "${data.vcustomerEmailAddress2}",
    "venquiry_date": "${data.denquiryDate}",
    "iproperty_id": "${data.ipropertyId}",
    "idivision_category_id": 0,
    "idivision_id": 0,
    "vcreated_by": "$vempCode",
    "mour_offer": "${data.mourOffer}",
    "ilead_source": "${data.ileadSource}",
    "vlead_by": "${data.vleadBy}",
    "vremarks": "${data.vremarks}",
    "ibusiness_area_id": 0,
    "vproperty_enquiry_code": "${data.vpropertyEnquiryCode}",
    "vtemp_customer_code": "${data.vtempCustomerCode}",
    "vagent_code": "${data.vagentCode}",
    "cenquiry_status": "A",
    "ipayment_terms_id": "${data.ipaymentTermsId}",
    "icountry_id": data.icountryId,
    "ibillboard_location_id": "${data.ibillboardLocationId}",
    "clead_qualification": "${data.cleadQualification}",
    "ienquiry_detail_id": 0,
    "cstatus": "A"
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
    model = EnquiryGenerationMasterModel.fromJson(jsonDecode(responseString));
    int id = int.parse(model.vtransactionCode!);
    return id;
  }
}

Future<String?> addReminders(ReminderDetail data) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print(data.dnextActivityDate);
  print(data.ienquiryId);
  print(data.id);
  final msg = jsonEncode({
    "id": data.id,
    "vnext_activity": "${data.vnextActivity}",
    "ienquiry_id": "${data.ienquiryId}",
    "iactivity_mode": "${data.iactivityMode}",
    "vnext_activity_date": "${data.dnextActivityDate}",
    "vcreated_by": "$vempCode",
    "dcreated_date": "",
    "cstatus": "A",
    "creminder_status": "${data.creminderStatus}",
    "dupdated_date": "",
    "vupdated_by": "",
    "vtime": "${data.vtime}",
    "cnotification_sent": "N",
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addEnquiryRemindersMaster"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    // model = ReminderDetail.fromJson(jsonDecode(responseString));
    return response.statusCode.toString();
  }
}

Future<int?> addNotesDetails(NoteDetail data) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  CustomerVisitNoteDetailModel model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print("save Notes Details=========");
  print(data.ddate);
  print(data.icustomerVisitNoteMasterId);
  final msg = jsonEncode({
    "id": data.id,
    "icustomer_visit_note_master_id": data.icustomerVisitNoteMasterId,
    "imode": data.imode,
    "vremarks": "${data.vremarks}",
    "vcommunicated_to": "${data.vcommunicatedTo}",
    "vdate": "${data.ddate}",
    "vcreated_by": vempCode,
    "vupdated_by": "",
    "dcreated_date": "",
    "dupdated_date": "",
    "cstatus": "A",
    "ireminder_master_id": data.ireminderMasterId,
    "lcall_log_id": data.lcallLogId,
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addCustomerVisitNoteDetail"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String responseString = response.body;
    model = CustomerVisitNoteDetailModel.fromJson(jsonDecode(responseString));
    return int.parse(model.vtransactionCode!);
  }
}

Future<int?> addNotesMaster(NoteMaster data) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  CustomerVisitNoteMasterModel model;
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print(dcreatedDate);
  print(data.dcreatedDate);
  print(data.ienquiryId);
  final msg = jsonEncode({
    "id": "",
    "vtransaction_code": "${data.vtransactionCode}",
    "itrnsaction_type": 0,
    "ienquiry_id": data.ienquiryId,
    "vcreated_by": vempCode,
    "vcustomer_name": null,
    "vupdated_by": null,
    "dcreated_date": "",
    "dupdated_date": null,
    "cstatus": "A"
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addCustomerVisitNoteMaster"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    model = CustomerVisitNoteMasterModel.fromJson(jsonDecode(responseString));
    return int.parse(model.vtransactionCode!);
  }
}

Future addCallLogs(
    String num, String timeTaken, DateTime dateTime, int id) async {
  print(dateTime);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  var url = sharedPreferences.get("url");
  var dcreatedDate = DateTime.now();
  print("addcallLogs..........");
  print(id);
  print(dcreatedDate);
  print(dateTime);
  print(timeTaken);
  final msg = jsonEncode({
    "id": "0",
    "lcustomer_id": "$id",
    "vemp_code": "$vempCode",
    "lmobile_id": "5",
    "vfrom_time": "$dateTime",
    "mduration": "",
    "vduration": "$timeTaken",
    "vmobile_to": "$num",
    "vremarks": " ",
    "vcreated_by": "$vempCode",
    "vupdated_by": "",
    "cstatus": "A"
  });
  var response = await http.post(
    Uri.parse("$url/crmc/addCallLogs"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("response======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
  }
}

Future<bool?> call(String phone_number) async {
  bool? b = await FlutterPhoneDirectCaller.callNumber(phone_number);
  print(b);
  return b;
}

//Get Methods

Future<Iterable<CallLogEntry>> getCallLogs(int id) async {
  await Future.delayed(Duration(seconds: 2));
  final Iterable<CallLogEntry> cLog = await CallLog.get();
  int x = cLog.first.timestamp! + 0;
  String num = cLog.first.number!;
  int duration = cLog.first.duration!;
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(x);
//Call the add call logs function to insert data to the database
  print("Under Call Log Function: $dateTime");
  print("Under Call Log Number: $num");
  String timeTaken = intToTimeLeft(duration);
  print("Under Call Log Duration: $timeTaken");
  addCallLogs(num, timeTaken, dateTime, id);
  for (CallLogEntry entry in cLog) {
    if (entry.number == "0729431738") {
      // String time= intToTimeLeft(entry.duration!);
      // print('-------------------------------------');
      // print('F. NUMBER  : ${entry.formattedNumber}');
      // print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
      // print('NUMBER     : ${entry.number}');
      // print('NAME       : ${entry.name}');
      // print('TYPE       : ${entry.callType}');
      // print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(
      //     entry.timestamp!)}');
      // print('DURATION   : $time');
      // print('ACCOUNT ID : ${entry.phoneAccountId}');
      // print('ACCOUNT ID : ${entry.phoneAccountId}');
      // print('SIM NAME   : ${entry.simDisplayName}');
      // print('-------------------------------------');
    }
  }
  print('');
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  return cLog;
}

Future<LeadQualificationMasterModel?> getLeadQualiFicationList(
    String vqualificationName) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({"vqualification": "$vqualificationName"});
  var response = await http.post(
    Uri.parse("$url/crmc/getLeadQualificationMasterLists"),
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
    final dataModel =
        LeadQualificationMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<PaymentTermsMasterModel?> getPaymentTermsList() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({});
  var response = await http.post(
    Uri.parse("$url/crmc/getPaymentTermsMasterList"),
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
    final dataModel =
        PaymentTermsMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<EnquirySourceModel?> getEnquirySourceList(String venquirySource) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({"venquiry_source": "$venquirySource"});
  var response = await http.post(
    Uri.parse("$url/crmc/getEnquirySourceList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print("===========query type=======");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = EnquirySourceModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<PropertyBookingAgentModel?> getAgentList(String vagentName) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({"vagent_name": "$vagentName"});
  var response = await http.post(
    Uri.parse("$url/crmc/getPropertyBookingAgentList"),
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
    final dataModel =
        PropertyBookingAgentModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<BillBoardMasterModel?> getBilboardLocationList() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({});
  var response = await http.post(
    Uri.parse("$url/crmc/getBillBoardMasterLists"),
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
    final dataModel = BillBoardMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<EnquiryGenerationMasterModel?> getEnquiryList(
    int id, String vcustomerName, String cleadQualification) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  print("url in function=====");
  print(url);
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");
  final msg = jsonEncode({
    "clead_qualification": "$cleadQualification",
    "id": id,
    "vcustomer_name": "$vcustomerName",
    "vemp_code": "$vempCode"
  });
  var response = await http.post(
    Uri.parse("$url/crmc/getEnquiryGenerationMasterList"),
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
    final dataModel =
        EnquiryGenerationMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<EnquiryRemindersMasterModel?> getReminderList(int mode, int ienquiryId,
    String vdate, int id, String vnextActivity, String creminder_status) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var url = sharedPreferences.get("url");
  print(url);
  var authToken = sharedPreferences.get("authToken");
  var vempCode = sharedPreferences.get("vempCode");

  print('step 4===========');
  final msg = jsonEncode({
    "iactivity_mode": mode,
    "id": id,
    "vnext_activity_date": "$vdate",
    "ienquiry_id": ienquiryId,
    "creminder_status": "$creminder_status",
    "vcreated_by": "$vempCode",
    "vnext_activity": "$vnextActivity",
    "inotification": 0,
  });
  var response = await http.post(
    Uri.parse("$url/crmc/getEnquiryRemindersMasterList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel =
        EnquiryRemindersMasterModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<CallLogDataModel?> getCallLogList(int ienquiry_id, int id) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({
    "id": id,
    "lcustomer_id": ienquiry_id,
  });
  var response = await http.post(
    Uri.parse("$url/crmc/getCallLogsMasterList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = CallLogDataModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<CustomerVisitNoteDetailModel?> getNoteDetail(
    int id,
    int imode,
    int icustomerVisitNoteMasterId,
    int ienquiry_id,
    int ireminderId,
    int lcallLogId) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({
    "id": id,
    "icustomer_visit_note_master_id": 0,
    "imode": 0,
    "ienquiry_id": ienquiry_id,
    "ireminder_master_id": ireminderId,
    "lcall_log_id": lcallLogId
  });
  var response = await http.post(
    Uri.parse("$url/crmc/getCustomerVisitNoteDetailList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel =
        CustomerVisitNoteDetailModel.fromJson(jsonDecode(responseString));
    return dataModel;
  }
}

Future<int?> getNoteMasterList(
    int id, int ienquiryId, String vtransactionCode) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({
    "id": id,
    "vtransaction_code": "$vtransactionCode",
    "ienquiry_id": ienquiryId
  });
  var response = await http.post(
    Uri.parse("$url/crmc/getCustomerVisitNoteMasterLists"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel =
        CustomerVisitNoteMasterModel.fromJson(jsonDecode(responseString));
    if (dataModel.noteMaster.isNotEmpty) {
      int? icustomerVisitNoteMasterId = dataModel.noteMaster[0].id;
      return icustomerVisitNoteMasterId;
    } else {
      return 0;
    }
  }
}

Future<int?> getFireBaseToken(String vempCode) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var authToken = sharedPreferences.get("authToken");
  var url = sharedPreferences.get("url");
  final msg = jsonEncode({"vemp_code": "$vempCode"});
  print(url);
  var response = await http.post(
    Uri.parse("$url/crmc/getFireBaseTokenList"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$authToken',
    },
    body: msg,
  );
  print(response.body);
  if (response.statusCode == 200) {
    String responseString = response.body;
    final dataModel = FireBaseTokenModel.fromJson(jsonDecode(responseString));
    if (dataModel.tokenList!.isNotEmpty) {
      int? itoken_id = dataModel.tokenList![0].id;
      return itoken_id;
    } else {
      return 0;
    }
  }
}
