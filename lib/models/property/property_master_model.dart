// To parse this JSON data, do
//
//     final propertyMasterModel = propertyMasterModelFromJson(jsonString);

import 'dart:convert';

PropertyMasterModel propertyMasterModelFromJson(String str) => PropertyMasterModel.fromJson(json.decode(str));

String propertyMasterModelToJson(PropertyMasterModel data) => json.encode(data.toJson());

class PropertyMasterModel {
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<PropertyList> propertyList;

  PropertyMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.propertyList,
  });

  factory PropertyMasterModel.fromJson(Map<String, dynamic> json) => PropertyMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    propertyList: List<PropertyList>.from(json["detailList"].map((x) => PropertyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(propertyList.map((x) => x.toJson())),
  };
}

class PropertyList {
  int id;
  String vpropertyName;

  PropertyList({
    required this.id,
    required this.vpropertyName,
  });

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
    id: json["id"],
    vpropertyName: json["vproperty_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vproperty_name": vpropertyName,
  };
}
