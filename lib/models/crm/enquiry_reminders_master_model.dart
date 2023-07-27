// To parse this JSON data, do
//
//     final enquiryRemindersMasterModel = enquiryRemindersMasterModelFromJson(jsonString);

import 'dart:convert';

EnquiryRemindersMasterModel enquiryRemindersMasterModelFromJson(String str) =>
    EnquiryRemindersMasterModel.fromJson(json.decode(str));

String enquiryRemindersMasterModelToJson(EnquiryRemindersMasterModel data) =>
    json.encode(data.toJson());

class EnquiryRemindersMasterModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<ReminderDetail> remiderList;

  EnquiryRemindersMasterModel({
    required this.vstatusRemarks,
    required this.vtransactionCode,
    required this.vqueryResult,
    required this.cstatus,
    required this.remiderList,
  });

  factory EnquiryRemindersMasterModel.fromJson(Map<String, dynamic> json) =>
      EnquiryRemindersMasterModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        remiderList: List<ReminderDetail>.from(
            json["detailList"].map((x) => ReminderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "detailList": List<dynamic>.from(remiderList.map((x) => x.toJson())),
      };
}

class ReminderDetail {
  int? _id;
  late int _iactivityMode;
  String? _dnextActivityDate;
  String? _vnextActivity;
  late int _ienquiryId;
  String? _vcreatedBy;
  String? _vupdatedBy;
  String? _vcustomerName;
  String? _dcreatedDate;
  String? _dupdatedDate;
  String? _creminderStatus;
  String? _cstatus;
  String? _vnextActivityDate;
  String? _vcreatedDate;
  String? _vmode;
  String? _vcreatedByName;
  String? _vupdatedByName;
  String? _vtime;

  ReminderDetail(
      this._id,
      this._iactivityMode,
      this._dnextActivityDate,
      this._vnextActivity,
      this._ienquiryId,
      this._vcreatedBy,
      this._vupdatedBy,
      this._vcustomerName,
      this._dcreatedDate,
      this._dupdatedDate,
      this._creminderStatus,
      this._cstatus,
      this._vnextActivityDate,
      this._vcreatedDate,
      this._vmode,
      this._vcreatedByName,
      this._vupdatedByName,this._vtime);

  factory ReminderDetail.fromJson(Map<String, dynamic> json) => ReminderDetail(
        json["id"],
        json["iactivity_mode"],
        json["dnext_activity_date"],
        json["vnext_activity"],
        json["ienquiry_id"],
        json["vcreated_by"],
        json["vupdated_by"],
        json["vcustomer_name"],
        json["dcreated_date"],
        json["dupdated_date"],
        json["creminder_status"],
        json["cstatus"],
        json["vnext_activity_date"],
        json["vcreated_date"],
        json["vmode"],
        json["vcreated_by_name"],
        json["vupdated_by_name"],
        json["vtime"],
      );


  Map<String, dynamic> toJson() => {
        "id": _id,
        "iactivity_mode": _iactivityMode,
        "dnext_activity_date": _dnextActivityDate,
        "vnext_activity": _vnextActivity,
        "ienquiry_id": _ienquiryId,
        "vcreated_by": _vcreatedBy,
        "vupdated_by": _vupdatedBy,
        "vcustomer_name": _vcustomerName,
        "dcreated_date": _dcreatedDate,
        "dupdated_date": _dupdatedDate,
        "creminder_status": _creminderStatus,
        "cstatus": _cstatus,
        "vnext_activity_date": _vnextActivityDate,
        "vcreated_date": _vcreatedDate,
        "vmode": _vmode,
        "vcreated_by_name": _vcreatedByName,
        "vupdated_by_name": _vupdatedByName,
        "vtime": _vtime,
      };
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['iactivity_mode'] = _iactivityMode;
    map['dnext_activity_date'] = _dnextActivityDate;
    map['vnext_activity'] = _vnextActivity;
    map['ienquiry_id'] = _ienquiryId;
    map['vcreated_by'] = _vcreatedBy;
    map['vupdated_by'] = _vupdatedBy;
    map['dcreated_date'] = _dcreatedDate;
    map['dupdated_date'] = _dupdatedDate;
    map['creminder_status'] = _creminderStatus;
    map['cstatus'] = _cstatus;
    map['vtime'] = _vtime;

    return map;
  }

  // Extract a Note object from a Map object
  ReminderDetail.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._iactivityMode = map['iactivity_mode'];
    this._dnextActivityDate=  map['dnext_activity_date'];
    this._vnextActivity = map['vnext_activity'];
    this._ienquiryId = map['ienquiry_id'];
    this._vcreatedBy = map['vcreated_by'];
    this._vupdatedBy = map['vupdated_by'];
    this._dcreatedDate =  map['dcreated_date'];
    this._dupdatedDate =  map['dupdated_date'];
    this._creminderStatus = map['creminder_status'];
    this._cstatus = map['cstatus'];
    this._vtime = map['vtime'];
  }

  String? get vupdatedByName => _vupdatedByName;

  set vupdatedByName(String? value) {
    _vupdatedByName = value;
  }

  String? get vcreatedByName => _vcreatedByName;

  set vcreatedByName(String? value) {
    _vcreatedByName = value;
  }  String? get vtime => _vtime;

  set vtime(String? value) {
    _vtime = value;
  }

  String? get vmode => _vmode;

  set vmode(String? value) {
    _vmode = value;
  }

  String? get vcreatedDate => _vcreatedDate;

  set vcreatedDate(String? value) {
    _vcreatedDate = value;
  }

  String? get vnextActivityDate => _vnextActivityDate;

  set vnextActivityDate(String? value) {
    _vnextActivityDate = value;
  }

  String? get cstatus => _cstatus;

  set cstatus(String? value) {
    _cstatus = value;
  }

  String? get creminderStatus => _creminderStatus;

  set creminderStatus(String? value) {
    _creminderStatus = value;
  }

  String? get dupdatedDate => _dupdatedDate;

  set dupdatedDate(String? value) {
    _dupdatedDate = value;
  }

  String? get dcreatedDate => _dcreatedDate;

  set dcreatedDate(String? value) {
    _dcreatedDate = value;
  }

  String? get vcustomerName => _vcustomerName;

  set vcustomerName(String? value) {
    _vcustomerName = value;
  }

  String? get vupdatedBy => _vupdatedBy;

  set vupdatedBy(String? value) {
    _vupdatedBy = value;
  }

  String? get vcreatedBy => _vcreatedBy;

  set vcreatedBy(String? value) {
    _vcreatedBy = value;
  }

  int get ienquiryId => _ienquiryId;

  set ienquiryId(int value) {
    _ienquiryId = value;
  }

  String? get vnextActivity => _vnextActivity;

  set vnextActivity(String? value) {
    _vnextActivity = value;
  }

  String? get dnextActivityDate => _dnextActivityDate;

  set dnextActivityDate(String? value) {
    _dnextActivityDate = value;
  }

  int get iactivityMode => _iactivityMode;

  set iactivityMode(int value) {
    _iactivityMode = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}

