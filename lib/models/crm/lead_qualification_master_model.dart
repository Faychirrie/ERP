import 'dart:convert';
LeadQualificationMasterModel leadQualificationMasterModelFromJson(String str) =>
    LeadQualificationMasterModel.fromJson(json.decode(str));

String leadQualificationMasterModelToJson(LeadQualificationMasterModel data) =>
    json.encode(data.toJson());

class LeadQualificationMasterModel {
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<QualificationList> qualificationList;

  LeadQualificationMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.qualificationList,
  });

  factory LeadQualificationMasterModel.fromJson(Map<String, dynamic> json) => LeadQualificationMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    qualificationList: List<QualificationList>.from(json["detailList"].map((x) => QualificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(qualificationList.map((x) => x.toJson())),
  };
}

class QualificationList {
  int id;
  String vqualification;
  String vqualification_description;
  String cstatus;
  String clead_qualification;

  QualificationList({
    required this.id,
    required this.vqualification,
    required this.vqualification_description,
    required this.cstatus,
    required this.clead_qualification,
  });

  factory QualificationList.fromJson(Map<String, dynamic> json) =>
      QualificationList(
        id: json["id"],
        vqualification: json["vqualification"],
        vqualification_description: json["vqualification_description"],
        cstatus: json["cstatus"],
        clead_qualification: json["clead_qualification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vqualification": vqualification,
        "vqualification_description": vqualification_description,
        "cstatus": cstatus,
        "clead_qualification": clead_qualification,
      };
}
