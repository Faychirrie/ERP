// To parse this JSON data, do
//
//     final customerVisitNoteDetailModel = customerVisitNoteDetailModelFromJson(jsonString);

import 'dart:convert';

CustomerVisitNoteDetailModel customerVisitNoteDetailModelFromJson(String str) =>
    CustomerVisitNoteDetailModel.fromJson(json.decode(str));

String customerVisitNoteDetailModelToJson(CustomerVisitNoteDetailModel data) =>
    json.encode(data.toJson());

class CustomerVisitNoteDetailModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String cstatus;
  List<NoteDetail> noteDetail;

  CustomerVisitNoteDetailModel({
    required this.vstatusRemarks,
    required this.vtransactionCode,
    required this.vqueryResult,
    required this.cstatus,
    required this.noteDetail,
  });

  factory CustomerVisitNoteDetailModel.fromJson(Map<String, dynamic> json) =>
      CustomerVisitNoteDetailModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        noteDetail: List<NoteDetail>.from(
            json["detailList"].map((x) => NoteDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "detailList": List<dynamic>.from(noteDetail.map((x) => x.toJson())),
      };
}

class NoteDetail {
  int? _id;
  late int _icustomerVisitNoteMasterId;
  int? _ireminderMasterId;
  late int _imode;
  String? _vremarks;
  String? _vcommunicatedTo;
  String? _vcustomerName;
  String? _ddate;
  String? _vcreatedBy;
  String? _vupdatedBy;
  String? _dcreatedDate;
  String? _dupdatedDate;
  String? _cstatus;
  String? _vdate;
  String? _vcreatedDate;
  String? _vcreatedByName;
  String? _vupdatedByName;
  String? _vmode;
  late int _ienquiryId;
  late int _lcallLogId;

  NoteDetail(
      this._id,
      this._icustomerVisitNoteMasterId,
      this._imode,
      this._vremarks,
      this._vcommunicatedTo,
      this._vcustomerName,
      this._ddate,
      this._vcreatedBy,
      this._vupdatedBy,
      this._dcreatedDate,
      this._dupdatedDate,
      this._cstatus,
      this._vdate,
      this._vcreatedDate,
      this._vcreatedByName,
      this._vupdatedByName,
      this._vmode,
      this._ireminderMasterId,
      this._ienquiryId,
      this._lcallLogId
      );

  factory NoteDetail.fromJson(Map<String, dynamic> json) => NoteDetail(
        json["id"],
        json["icustomer_visit_note_master_id"],
        json["imode"],
        json["vremarks"],
        json["vcommunicated_to"],
        json["vcustomer_name"],
        json["ddate"],
        json["vcreated_by"],
        json["vupdated_by"],
        json["dcreated_date"],
        json["dupdated_date"],
        json["cstatus"],
        json["vdate"],
        json["vcreated_date"],
        json["vcreated_by_name"],
        json["vupdated_by_name"],
        json["vmode"],
        json["ireminder_master_id"],
        json["ienquiry_id"],
        json["lcall_log_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": _id,
        "icustomer_visit_note_master_id": _icustomerVisitNoteMasterId,
        "imode": _imode,
        "vremarks": _vremarks,
        "vcommunicated_to": _vcommunicatedTo,
        "vcustomer_name": _vcustomerName,
        "ddate": _ddate,
        "vcreated_by": _vcreatedBy,
        "vupdated_by": _vupdatedBy,
        "dcreated_date": _dcreatedDate,
        "dupdated_date": _dupdatedDate,
        "cstatus": _cstatus,
        "vdate": _vdate,
        "vcreated_date": _vcreatedDate,
        "vcreated_by_name": _vcreatedByName,
        "vupdated_by_name": _vupdatedByName,
        "vmode": _vmode,
        "ireminder_master_id": _ireminderMasterId,
        "ienquiry_id": _ienquiryId,
        "lcall_log_id": _lcallLogId,
      };
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['icustomer_visit_note_master_id'] = _icustomerVisitNoteMasterId;
    map['imode'] = _imode;
    map['vremarks'] = _vremarks;
    map['vcommunicated_to'] = _vcommunicatedTo;
    map['ddate'] = _ddate;
    map['vcreated_by'] = this._vcreatedBy;
    map['dcreated_date'] = this._dcreatedDate;
    map['vupdated_by'] = this._vupdatedBy;
    map['dupdated_date'] = this._dupdatedDate;
    map['cstatus'] = this._cstatus;

    return map;
  }

  // Extract a Note object from a Map object
  NoteDetail.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._icustomerVisitNoteMasterId = map['icustomer_visit_note_master_id'];
    this._imode = map['imode'];
    this._vremarks = map['vremarks'];
    this._vcommunicatedTo = map['vcommunicated_to'];
    this._ddate = map['ddate'];
    this._vcreatedBy = map['vcreated_by'];
    this._vupdatedBy = map['vupdated_by'];
    this._dcreatedDate = map['dcreated_date'];
    this._dupdatedDate = map['dupdated_date'];
    this._cstatus = map['cstatus'];
  }

  int get lcallLogId => _lcallLogId;

  set lcallLogId(int value) {
    _lcallLogId = value;
  }

  int get ienquiryId => _ienquiryId;

  set ienquiryId(int value) {
    _ienquiryId = value;
  }

  int? get ireminderMasterId => _ireminderMasterId;

  set ireminderMasterId(int? value) {
    _ireminderMasterId = value;
  }

  String? get vmode => _vmode;

  set vmode(String? value) {
    _vmode = value;
  }

  String? get vupdatedByName => _vupdatedByName;

  set vupdatedByName(String? value) {
    _vupdatedByName = value;
  }

  String? get vcreatedByName => _vcreatedByName;

  set vcreatedByName(String? value) {
    _vcreatedByName = value;
  }

  String? get vcreatedDate => _vcreatedDate;

  set vcreatedDate(String? value) {
    _vcreatedDate = value;
  }

  String? get vdate => _vdate;

  set vdate(String? value) {
    _vdate = value;
  }

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

  String? get vcreatedBy => _vcreatedBy;

  set vcreatedBy(String? value) {
    _vcreatedBy = value;
  }

  String? get ddate => _ddate;

  set ddate(String? value) {
    _ddate = value;
  }

  String? get vcustomerName => _vcustomerName;

  set vcustomerName(String? value) {
    _vcustomerName = value;
  }

  String? get vcommunicatedTo => _vcommunicatedTo;

  set vcommunicatedTo(String? value) {
    _vcommunicatedTo = value;
  }

  String? get vremarks => _vremarks;

  set vremarks(String? value) {
    _vremarks = value;
  }

  int get imode => _imode;

  set imode(int value) {
    _imode = value;
  }

  int get icustomerVisitNoteMasterId => _icustomerVisitNoteMasterId;

  set icustomerVisitNoteMasterId(int value) {
    _icustomerVisitNoteMasterId = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  @override
  String toString() {
    return 'NoteDetail{_id: $_id, _icustomerVisitNoteMasterId: $_icustomerVisitNoteMasterId, _imode: $_imode, _vremarks: $_vremarks, _vcommunicatedTo: $_vcommunicatedTo, _vcustomerName: $_vcustomerName, _ddate: $_ddate, _vcreatedBy: $_vcreatedBy, _vupdatedBy: $_vupdatedBy, _dcreatedDate: $_dcreatedDate, _dupdatedDate: $_dupdatedDate, _cstatus: $_cstatus, _vdate: $_vdate, _vcreatedDate: $_vcreatedDate, _vcreatedByName: $_vcreatedByName, _vupdatedByName: $_vupdatedByName, _vmode: $_vmode}';
  }
}
