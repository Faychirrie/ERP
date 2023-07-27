// To parse this JSON data, do
//
//     final paymentTermsMasterModel = paymentTermsMasterModelFromJson(jsonString);

import 'dart:convert';

PaymentTermsMasterModel paymentTermsMasterModelFromJson(String str) => PaymentTermsMasterModel.fromJson(json.decode(str));

String paymentTermsMasterModelToJson(PaymentTermsMasterModel data) => json.encode(data.toJson());

class PaymentTermsMasterModel {
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<PaymentTermsList> paymentTermsList;

  PaymentTermsMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.paymentTermsList,
  });

  factory PaymentTermsMasterModel.fromJson(Map<String, dynamic> json) => PaymentTermsMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    paymentTermsList: List<PaymentTermsList>.from(json["detailList"].map((x) => PaymentTermsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(paymentTermsList.map((x) => x.toJson())),
  };
}

class PaymentTermsList {
  int id;
  String vpaymentTermName;
  String vpaymentTermDescription;
  String vcreatedBy;
  DateTime dcreatedDate;
  String? vupdatedBy;
  DateTime? dupdatedDate;
  String cstatus;

  PaymentTermsList({
    required this.id,
    required this.vpaymentTermName,
    required this.vpaymentTermDescription,
    required this.vcreatedBy,
    required this.dcreatedDate,
    this.vupdatedBy,
    this.dupdatedDate,
    required this.cstatus,
  });

  factory PaymentTermsList.fromJson(Map<String, dynamic> json) => PaymentTermsList(
    id: json["id"],
    vpaymentTermName: json["vpayment_term_name"],
    vpaymentTermDescription: json["vpayment_term_description"],
    vcreatedBy: json["vcreated_by"],
    dcreatedDate: DateTime.parse(json["dcreated_date"]),
    vupdatedBy: json["vupdated_by"],
    // dupdatedDate: DateTime.parse(json["dupdated_date"]),
    cstatus: json["cstatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vpayment_term_name": vpaymentTermName,
    "vpayment_term_description": vpaymentTermDescription,
    "vcreated_by": vcreatedBy,
    "dcreated_date": dcreatedDate.toIso8601String(),
    "vupdated_by": vupdatedBy,
    "dupdated_date": dupdatedDate?.toIso8601String(),
    "cstatus": cstatus,
  };
}
