// To parse this JSON data, do
//
//     final callLogDataModel = callLogDataModelFromJson(jsonString);

import 'dart:convert';

CallLogDataModel callLogDataModelFromJson(String str) => CallLogDataModel.fromJson(json.decode(str));

String callLogDataModelToJson(CallLogDataModel data) => json.encode(data.toJson());

class CallLogDataModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<CallLogList> callLogList;

  CallLogDataModel({
     this.vstatusRemarks,
     this.vtransactionCode,
     this.vqueryResult,
     this.cstatus,
     required this.callLogList,
  });

  factory CallLogDataModel.fromJson(Map<String, dynamic> json) => CallLogDataModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    callLogList: List<CallLogList>.from(json["detailList"].map((x) => CallLogList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "detailList": List<dynamic>.from(callLogList.map((x) => x.toJson())),
  };
}

class CallLogList {
  int? id;
  int? longId;
  String? vempCode;
  int? lmobileId;
  int? lcustomerId;
  String? dfromTime;
  String? dtoTime;
  String? vmobileTo;
  double? mduration;
  String? vremarks;
  String? vcreatedBy;
  String? dcreatedDate;
  String? vupdatedBy;
  String? dupdatedDate;
  String? cstatus;
  String? vcustomerName;
  String? vmobileFrom;
  String? vfromTime;
  String? vtoTime;
  String? vduration;
  String? vtime;
  String? vcreatedByName;

  CallLogList({
     this.id,
     this.longId,
     this.vempCode,
     this.lmobileId,
     this.lcustomerId,
     this.dfromTime,
     this.dtoTime,
     this.vmobileTo,
     this.mduration,
     this.vremarks,
     this.vcreatedBy,
     this.dcreatedDate,
     this.vupdatedBy,
     this.dupdatedDate,
     this.cstatus,
     this.vcustomerName,
     this.vmobileFrom,
     this.vfromTime,
     this.vtoTime,
     this.vduration,
     this.vtime,
     this.vcreatedByName,
  });

  factory CallLogList.fromJson(Map<String, dynamic> json) => CallLogList(
    id: json["id"],
    longId: json["long_id"],
    vempCode: json["vemp_code"],
    lmobileId: json["lmobile_id"],
    lcustomerId: json["lcustomer_id"],
    dfromTime: json["dfrom_time"],
    dtoTime: json["dto_time"],
    vmobileTo: json["vmobile_to"],
    mduration: json["mduration"],
    vremarks: json["vremarks"],
    vcreatedBy: json["vcreated_by"],
    dcreatedDate: json["dcreated_date"],
    vupdatedBy: json["vupdated_by"],
    dupdatedDate: json["dupdated_date"],
    cstatus: json["cstatus"],
    vcustomerName: json["vcustomer_name"],
    vmobileFrom: json["vmobile_from"],
    vfromTime: json["vfrom_time"],
    vtoTime: json["vto_time"],
    vduration: json["vduration"],
    vtime: json["vtime"],
    vcreatedByName: json["vcreated_by_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "long_id": longId,
    "vemp_code": vempCode,
    "lmobile_id": lmobileId,
    "lcustomer_id": lcustomerId,
    "dfrom_time": dfromTime,
    "dto_time": dtoTime,
    "vmobile_to": vmobileTo,
    "mduration": mduration,
    "vremarks": vremarks,
    "vcreated_by": vcreatedBy,
    "dcreated_date": dcreatedDate,
    "vupdated_by": vupdatedBy,
    "dupdated_date": dupdatedDate,
    "cstatus": cstatus,
    "vcustomer_name": vcustomerName,
    "vmobile_from": vmobileFrom,
    "vfrom_time": vfromTime,
    "vto_time": vtoTime,
    "vduration": vduration,
    "vtime": vtime,
    "vcreated_by_name": vcreatedByName,
  };
}
