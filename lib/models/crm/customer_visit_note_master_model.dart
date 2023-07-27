// To parse this JSON data, do
//
//     final customerVisitNoteMasterModel = customerVisitNoteMasterModelFromJson(jsonString);

import 'dart:convert';

CustomerVisitNoteMasterModel customerVisitNoteMasterModelFromJson(String str) =>
    CustomerVisitNoteMasterModel.fromJson(json.decode(str));

String customerVisitNoteMasterModelToJson(CustomerVisitNoteMasterModel data) =>
    json.encode(data.toJson());

class CustomerVisitNoteMasterModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String cstatus;
  List<NoteMaster> noteMaster;

  CustomerVisitNoteMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.cstatus,
    required this.noteMaster,
  });

  factory CustomerVisitNoteMasterModel.fromJson(Map<String, dynamic> json) =>
      CustomerVisitNoteMasterModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        noteMaster: List<NoteMaster>.from(
            json["detailList"].map((x) => NoteMaster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "noteMaster": List<dynamic>.from(noteMaster.map((x) => x.toJson())),
      };
}

class NoteMaster {
  int? _id;
  String? _vtransactionCode;
  int _itrnsactionType;
  int _ienquiryId;
  String? _vcreatedBy;
  String? _vcustomerName;
  String? _vupdatedBy;
  String? _dcreatedDate;
  String? _dupdatedDate;
  String? _cstatus;

  NoteMaster(
      this._id,
      this._vtransactionCode,
      this._itrnsactionType,
      this._ienquiryId,
      this._vcreatedBy,
      this._vcustomerName,
      this._vupdatedBy,
      this._dcreatedDate,
      this._dupdatedDate,
      this._cstatus);

  factory NoteMaster.fromJson(Map<String, dynamic> json) => NoteMaster(
        json["id"],
        json["vtransaction_code"],
        json["itrnsaction_type"],
        json["ienquiry_id"],
        json["vcreated_by"],
        json["vcustomer_name"],
        json["vupdated_by"],
        json["dcreated_date"],
        json["dupdated_date"],
        json["cstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": _id,
        "vtransaction_code": _vtransactionCode,
        "itrnsaction_type": _itrnsactionType,
        "ienquiry_id": _ienquiryId,
        "vcreated_by": _vcreatedBy,
        "vcustomer_name": _vcustomerName,
        "vupdated_by": _vupdatedBy,
        "dcreated_date": _dcreatedDate,
        "dupdated_date": _dupdatedDate,
        "cstatus": _cstatus,
      };

  String? get cstatus => _cstatus;

  set cstatus(String? value) {
    _cstatus = value;
  }

  String? get dupdatedDate => _dupdatedDate;

  set dupdatedDate(String? value) {
    _dupdatedDate = value;
  }

  String? get dcreatedDate => _dcreatedDate;

  set dcreatedDate(String? value) {
    _dcreatedDate = value;
  }

  String? get vupdatedBy => _vupdatedBy;

  set vupdatedBy(String? value) {
    _vupdatedBy = value;
  }

  String? get vcustomerName => _vcustomerName;

  set vcustomerName(String? value) {
    _vcustomerName = value;
  }

  String? get vcreatedBy => _vcreatedBy;

  set vcreatedBy(String? value) {
    _vcreatedBy = value;
  }

  int get ienquiryId => _ienquiryId;

  set ienquiryId(int value) {
    _ienquiryId = value;
  }

  int get itrnsactionType => _itrnsactionType;

  set itrnsactionType(int value) {
    _itrnsactionType = value;
  }

  String? get vtransactionCode => _vtransactionCode;

  set vtransactionCode(String? value) {
    _vtransactionCode = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}
