import 'dart:convert';
BillBoardMasterModel billBoardMasterModelFromJson(String str) =>
    BillBoardMasterModel.fromJson(json.decode(str));

String billBoardMasterModelToJson(BillBoardMasterModel data) =>
    json.encode(data.toJson());
class BillBoardMasterModel
{
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<BillBoardList> billBoardList;

  BillBoardMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.billBoardList,
  });

  factory BillBoardMasterModel.fromJson(Map<String, dynamic> json) => BillBoardMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    billBoardList: List<BillBoardList>.from(json["detailList"].map((x) => BillBoardList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(billBoardList.map((x) => x.toJson())),
  };
}
class BillBoardList {
  int id;
  String vbillboard_location;
  BillBoardList({
    required this.id,
    required this.vbillboard_location,
  });

  factory BillBoardList.fromJson(Map<String, dynamic> json) =>
      BillBoardList(
        id: json["id"],
        vbillboard_location: json["vbillboard_location"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vagent_code": vbillboard_location,
  };
}