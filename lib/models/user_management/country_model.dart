// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<CountryList> countryList;

  CountryModel({
    required this.vstatusRemarks,
     this.vtransactionCode,
     this.vqueryResult,
     this.cstatus,
    required this.countryList,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    countryList: List<CountryList>.from(json["detailList"].map((x) => CountryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "detailList": List<dynamic>.from(countryList.map((x) => x.toJson())),
  };
}

class CountryList {
  int countryId;
  String countryName;
  String countryCode;
  String ? vcreatedBy;
  String ? dcreatedDate;
  String ? vupdatedBy;
  String ? dupdatedDate;
  String ? cstatus;

  CountryList({
    required this.countryId,
    required this.countryName,
    required this.countryCode,
     this.vcreatedBy,
     this.dcreatedDate,
     this.vupdatedBy,
     this.dupdatedDate,
     this.cstatus,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
    countryId: json["country_id"],
    countryName: json["countryName"],
    countryCode: json["country_code"],
    vcreatedBy: json["vcreated_by"],
    dcreatedDate: json["dcreated_date"],
    vupdatedBy: json["vupdated_by"],
    dupdatedDate: json["dupdated_date"],
    cstatus: json["cstatus"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "countryName": countryName,
    "country_code": countryCode,
    "vcreated_by": vcreatedBy,
    "dcreated_date": dcreatedDate,
    "vupdated_by": vupdatedBy,
    "dupdated_date": dupdatedDate,
    "cstatus": cstatus,
  };
}
