import 'dart:convert';
EmployeeMasterModel employeeMasterModelFromJson(String str) =>
    EmployeeMasterModel.fromJson(json.decode(str));

String employeeMasterModelToJson(EmployeeMasterModel data) =>
    json.encode(data.toJson());

class EmployeeMasterModel
{
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<EmployeeMasterList> employeeMasterList;

  EmployeeMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.employeeMasterList,
  });

  factory EmployeeMasterModel.fromJson(Map<String, dynamic> json) => EmployeeMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    employeeMasterList: List<EmployeeMasterList>.from(json["detailList"].map((x) => EmployeeMasterList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(employeeMasterList.map((x) => x.toJson())),
  };
}

class EmployeeMasterList {
  String vemp_name;
  String vemp_code;
  EmployeeMasterList({
    required this.vemp_name,
    required this.vemp_code,
  });

  factory EmployeeMasterList.fromJson(Map<String, dynamic> json) =>
      EmployeeMasterList(
        vemp_name: json["vemp_name"],
        vemp_code: json["vemp_code"],
      );

  Map<String, dynamic> toJson() => {
    "vemp_name": vemp_name,
    "vemp_code": vemp_code,
  };
}