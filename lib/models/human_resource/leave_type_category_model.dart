// To parse this JSON data, do
//
//     final leaveTypeCategoryModel = leaveTypeCategoryModelFromJson(jsonString);

import 'dart:convert';

LeaveTypeCategoryModel leaveTypeCategoryModelFromJson(String str) => LeaveTypeCategoryModel.fromJson(json.decode(str));

String ?leaveTypeCategoryModelToJson(LeaveTypeCategoryModel data) => json.encode(data.toJson());

class LeaveTypeCategoryModel {
  String ?vstatusRemarks;
  String ?vtransactionCode;
  String ?vqueryResult;
  String ?cstatus;
  List<LeaveCategoryList> leaveCategoryList;

  LeaveTypeCategoryModel({
    this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    this.cstatus,
    required this.leaveCategoryList,
  });

  factory LeaveTypeCategoryModel.fromJson(Map<String, dynamic> json) => LeaveTypeCategoryModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    leaveCategoryList: List<LeaveCategoryList>.from(json["detailList"].map((x) => LeaveCategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "detailList": List<dynamic>.from(leaveCategoryList.map((x) => x.toJson())),
  };
}

class LeaveCategoryList {
  int ?id;
  String ?vleaveCategoryName;
  String ?vleaveCategoryDescription;
  String ?cencashable;
  String ?ccarryForwardAllowed;
  String ?cstatus;
  String ?vcreatedBy;
  String ?dcreateDate;
  String ?vupdatedBy;
  String ?vempFname;
  String ?dupdateDate;
  int ?ipriority;

  LeaveCategoryList({
    this.id,
    this.vleaveCategoryName,
    this.vleaveCategoryDescription,
    this.cencashable,
    this.ccarryForwardAllowed,
    this.cstatus,
    this.vcreatedBy,
    this.dcreateDate,
    this.vupdatedBy,
    this.vempFname,
    this.dupdateDate,
    this.ipriority,
  });

  factory LeaveCategoryList.fromJson(Map<String, dynamic> json) => LeaveCategoryList(
    id: json["id"],
    vleaveCategoryName: json["vleave_category_name"],
    vleaveCategoryDescription: json["vleave_category_description"],
    cencashable: json["cencashable"],
    ccarryForwardAllowed: json["ccarry_forward_allowed"],
    cstatus: json["cstatus"],
    vcreatedBy: json["vcreated_by"],
    dcreateDate: json["dcreate_date"],
    vupdatedBy: json["vupdated_by"],
    vempFname: json["vemp_fname"],
    dupdateDate: json["dupdate_date"],
    ipriority: json["ipriority"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vleave_category_name": vleaveCategoryName,
    "vleave_category_description": vleaveCategoryDescription,
    "cencashable": cencashable,
    "ccarry_forward_allowed": ccarryForwardAllowed,
    "cstatus": cstatus,
    "vcreated_by": vcreatedBy,
    "dcreate_date": dcreateDate,
    "vupdated_by": vupdatedBy,
    "vemp_fname": vempFname,
    "dupdate_date": dupdateDate,
    "ipriority": ipriority,
  };
}
