// To parse this JSON data, do
//
//     final enquirySourceModel = enquirySourceModelFromJson(jsonString);

import 'dart:convert';

EnquirySourceModel enquirySourceModelFromJson(String str) => EnquirySourceModel.fromJson(json.decode(str));

String enquirySourceModelToJson(EnquirySourceModel data) => json.encode(data.toJson());

class EnquirySourceModel {
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<SourceList> sourceList;

  EnquirySourceModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.sourceList,
  });

  factory EnquirySourceModel.fromJson(Map<String, dynamic> json) => EnquirySourceModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    sourceList: List<SourceList>.from(json["detailList"].map((x) => SourceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(sourceList.map((x) => x.toJson())),
  };
}

class SourceList {
  int id;
  String venquirySource;
  String venquiryDescription;
  dynamic dcreatedOn;
  dynamic vcreatedBy;
  dynamic dupdatedOn;
  dynamic vupdatedBy;
  String cstatus;

  SourceList({
    required this.id,
    required this.venquirySource,
    required this.venquiryDescription,
    this.dcreatedOn,
    this.vcreatedBy,
    this.dupdatedOn,
    this.vupdatedBy,
    required this.cstatus,
  });

  factory SourceList.fromJson(Map<String, dynamic> json) => SourceList(
    id: json["id"],
    venquirySource: json["venquiry_source"],
    venquiryDescription: json["venquiry_description"],
    dcreatedOn: json["dcreated_on"],
    vcreatedBy: json["vcreated_by"],
    dupdatedOn: json["dupdated_on"],
    vupdatedBy: json["vupdated_by"],
    cstatus: json["cstatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "venquiry_source": venquirySource,
    "venquiry_description": venquiryDescription,
    "dcreated_on": dcreatedOn,
    "vcreated_by": vcreatedBy,
    "dupdated_on": dupdatedOn,
    "vupdated_by": vupdatedBy,
    "cstatus": cstatus,
  };
}
