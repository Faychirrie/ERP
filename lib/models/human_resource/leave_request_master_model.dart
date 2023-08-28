// To parse this JSON data, do
//
//     final leaveRequestMasterModel = leaveRequestMasterModelFromJson(jsonString);

import 'dart:convert';

LeaveRequestMasterModel leaveRequestMasterModelFromJson(String str) =>
    LeaveRequestMasterModel.fromJson(json.decode(str));

String? leaveRequestMasterModelToJson(LeaveRequestMasterModel data) =>
    json.encode(data.toJson());

class LeaveRequestMasterModel {
  int? _id;
  String? _ddate;
  int? _ibusinessAreaId;
  String? _vbusinessAreaShortName;
  String? _vempCode;
  String? _vhandoverEmpCode;
  String? _vhandoverEmpCodeTo;
  String? _vleaveRequestCode;
  String? _vreason;
  String? _vreferenceNo;
  String? _capprovedStatus;
  String? _cstatus;
  String? _dcreatedDate;
  String? _vcreatedBy;
  String? _vupdatedBy;
  int? _ileaveRequestDetailId;
  String? _dleaveDate;
  int? _ileaveCountType;
  double? _mleaveCount;
  int? _ileaveType;

  LeaveRequestMasterModel(
      this._id,
      this._ddate,
      this._ibusinessAreaId,
      this._vbusinessAreaShortName,
      this._vempCode,
      this._vhandoverEmpCode,
      this._vhandoverEmpCodeTo,
      this._vleaveRequestCode,
      this._vreason,
      this._vreferenceNo,
      this._capprovedStatus,
      this._cstatus,
      this._dcreatedDate,
      this._vcreatedBy,
      this._vupdatedBy,
      this._ileaveRequestDetailId,
      this._dleaveDate,
      this._ileaveCountType,
      this._mleaveCount,
      this._ileaveType);

  factory LeaveRequestMasterModel.fromJson(Map<String, dynamic> json) =>
      LeaveRequestMasterModel(
        json["id"],
        json["ddate"],
        json["ibusiness_area_id"],
        json["vbusiness_area_short_name"],
        json["vemp_code"],
        json["vhandover_emp_code"],
        json["vhandover_emp_code_to"],
        json["vleave_request_code"],
        json["vreason"],
        json["vreference_no"],
        json["capproved_status"],
        json["cstatus"],
        json["dcreated_date"],
        json["vcreated_by"],
        json["vupdated_by"],
        json["ileave_request_detail_id"],
        json["dleave_date"],
        json["ileave_count_type"],
        json["mleave_count"],
        json["ileave_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ddate": ddate,
        "ibusiness_area_id": ibusinessAreaId,
        "vbusiness_area_short_name": vbusinessAreaShortName,
        "vemp_code": vempCode,
        "vhandover_emp_code": vhandoverEmpCode,
        "vhandover_emp_code_to": vhandoverEmpCodeTo,
        "vleave_request_code": vleaveRequestCode,
        "vreason": vreason,
        "vreference_no": vreferenceNo,
        "capproved_status": capprovedStatus,
        "cstatus": cstatus,
        "dcreated_date": dcreatedDate,
        "vcreated_by": vcreatedBy,
        "vupdated_by": vupdatedBy,
        "ileave_request_detail_id": ileaveRequestDetailId,
        "dleave_date": dleaveDate,
        "ileave_count_type": ileaveCountType,
        "mleave_count": mleaveCount,
        "ileave_type": ileaveType,
      };

  int? get ileaveType => _ileaveType;

  set ileaveType(int? value) {
    _ileaveType = value;
  }


  double? get mleaveCount => _mleaveCount;

  set mleaveCount(double? value) {
    _mleaveCount = value;
  }

  int? get ileaveCountType => _ileaveCountType;

  set ileaveCountType(int? value) {
    _ileaveCountType = value;
  }

  String? get dleaveDate => _dleaveDate;

  set dleaveDate(String? value) {
    _dleaveDate = value;
  }

  int? get ileaveRequestDetailId => _ileaveRequestDetailId;

  set ileaveRequestDetailId(int? value) {
    _ileaveRequestDetailId = value;
  }

  String? get vupdatedBy => _vupdatedBy;

  set vupdatedBy(String? value) {
    _vupdatedBy = value;
  }

  String? get vcreatedBy => _vcreatedBy;

  set vcreatedBy(String? value) {
    _vcreatedBy = value;
  }

  String? get dcreatedDate => _dcreatedDate;

  set dcreatedDate(String? value) {
    _dcreatedDate = value;
  }

  String? get cstatus => _cstatus;

  set cstatus(String? value) {
    _cstatus = value;
  }

  String? get capprovedStatus => _capprovedStatus;

  set capprovedStatus(String? value) {
    _capprovedStatus = value;
  }

  String? get vreferenceNo => _vreferenceNo;

  set vreferenceNo(String? value) {
    _vreferenceNo = value;
  }

  String? get vreason => _vreason;

  set vreason(String? value) {
    _vreason = value;
  }

  String? get vleaveRequestCode => _vleaveRequestCode;

  set vleaveRequestCode(String? value) {
    _vleaveRequestCode = value;
  }

  String? get vhandoverEmpCodeTo => _vhandoverEmpCodeTo;

  set vhandoverEmpCodeTo(String? value) {
    _vhandoverEmpCodeTo = value;
  }

  String? get vhandoverEmpCode => _vhandoverEmpCode;

  set vhandoverEmpCode(String? value) {
    _vhandoverEmpCode = value;
  }

  String? get vempCode => _vempCode;

  set vempCode(String? value) {
    _vempCode = value;
  }

  String? get vbusinessAreaShortName => _vbusinessAreaShortName;

  set vbusinessAreaShortName(String? value) {
    _vbusinessAreaShortName = value;
  }

  int? get ibusinessAreaId => _ibusinessAreaId;

  set ibusinessAreaId(int? value) {
    _ibusinessAreaId = value;
  }

  String? get ddate => _ddate;

  set ddate(String? value) {
    _ddate = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }
}
