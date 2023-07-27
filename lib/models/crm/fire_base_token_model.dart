// To parse this JSON data, do
//
//     final fireBaseTokenModel = fireBaseTokenModelFromJson(jsonString);

import 'dart:convert';

FireBaseTokenModel fireBaseTokenModelFromJson(String str) => FireBaseTokenModel.fromJson(json.decode(str));

String fireBaseTokenModelToJson(FireBaseTokenModel data) => json.encode(data.toJson());

class FireBaseTokenModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<TokenList>? tokenList;

  FireBaseTokenModel({
     this.vstatusRemarks,
     this.vtransactionCode,
     this.vqueryResult,
     this.cstatus,
     this.tokenList,
  });

  factory FireBaseTokenModel.fromJson(Map<String, dynamic> json) => FireBaseTokenModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    tokenList: List<TokenList>.from(json["detailList"].map((x) => TokenList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "detailList": List<dynamic>.from(tokenList!.map((x) => x.toJson())),
  };
}

class TokenList {
  int? id;
  String? vempCode;
  String? vtoken;
  String? cstatus;

  TokenList({
     this.id,
     this.vempCode,
     this.vtoken,
     this.cstatus,
  });

  factory TokenList.fromJson(Map<String, dynamic> json) => TokenList(
    id: json["id"],
    vempCode: json["vemp_code"],
    vtoken: json["vtoken"],
    cstatus: json["cstatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vemp_code": vempCode,
    "vtoken": vtoken,
    "cstatus": cstatus,
  };
}
