// To parse this JSON data, do
//
//     final enquiryGenerationMasterModel = enquiryGenerationMasterModelFromJson(jsonString?);

import 'dart:convert';
import 'dart:core';

EnquiryGenerationMasterModel enquiryGenerationMasterModelFromJson(
        String? str) =>
    EnquiryGenerationMasterModel.fromJson(json.decode(str!));

String? enquiryGenerationMasterModelToJson(EnquiryGenerationMasterModel data) =>
    json.encode(data.toJson());

class EnquiryGenerationMasterModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<EnquiryList> enquiryList;

  EnquiryGenerationMasterModel({
    required this.vstatusRemarks,
    required this.vtransactionCode,
    required this.vqueryResult,
    required this.cstatus,
    required this.enquiryList,
  });

  factory EnquiryGenerationMasterModel.fromJson(Map<String?, dynamic> json) =>
      EnquiryGenerationMasterModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        enquiryList: List<EnquiryList>.from(
            json["detailList"].map((x) => EnquiryList.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "enquiryList": List<dynamic>.from(enquiryList.map((x) => x.toJson())),
      };
}

class EnquiryList {
  late int? _id;
  String? _vcustomerName;
  String? _vcustomerAddress;
  String? _vpermanentCity;
  String? _vcustomerMobile1;
  String? _vcustomerMobile2;
  String? _vcustomerEmailAddress;
  String? _vcustomerEmailAddress2;
  String? _vpropertyEnquiryCode;
  String? _vtempCustomerCode;
  String? _denquiryDate;
  late int _ipropertyId;
  late int? _idivisionCategoryId;
  late int _ipaymentTermsId;
  late double _mourOffer;
  late int _ileadSource;
  late int? _ibusinessAreaId;
  String? _vremarks;
  String? _vagentCode;
  String? _vleadBy;
  String? _vcreatedBy;
  String? _dcreatedDate;
  String? _vupdatedBy;
  String? _dupdatedDate;
  String? _cstatus;
  String? _cenquiryStatus;
  String? _cleadQualification;
  late int _icountryId;
  late int _ibillboardLocationId;
  late int _ienquiryDetailId;
  String? _vcustomerMobile;
  String? _venquiryDate;
  String? _vpropertyName;
  String? _vleadByName;
  String? _vcreatedByName;
  String? _venquirySource;
  String? _vdivisionId;
  String? _vagentName;
  String? _vdivisionCategoryName;
  String? _vstatus;
  String? _vcountryCode;
  String? _vcountryName;
  String? _vleadQualification;
  String? _vstatusName;
  String? _vname;
  String? _vcityId;
  String? _vlistsize;
  String? _vshortName;
  String? _cityName;
  String? _vpayment_term_name;
  String? _vbillboard_location;
  String? _vtax_no;
  String? _finYear;
  int? _cityId;
  int? _inac_id;
  int? _icpd_id;

  EnquiryList(
    this._id,
    this._vcustomerName,
    this._vcustomerAddress,
    this._vpermanentCity,
    this._vcustomerMobile1,
    this._vcustomerMobile2,
    this._vcustomerEmailAddress,
    this._vcustomerEmailAddress2,
    this._vpropertyEnquiryCode,
    this._vtempCustomerCode,
    this._denquiryDate,
    this._ipropertyId,
    this._idivisionCategoryId,
    this._ipaymentTermsId,
    this._mourOffer,
    this._ileadSource,
    this._ibusinessAreaId,
    this._vremarks,
    this._vagentCode,
    this._vleadBy,
    this._vcreatedBy,
    this._dcreatedDate,
    this._vupdatedBy,
    this._dupdatedDate,
    this._cstatus,
    this._cenquiryStatus,
    this._cleadQualification,
    this._icountryId,
    this._ibillboardLocationId,
    this._ienquiryDetailId,
    this._vcustomerMobile,
    this._venquiryDate,
    this._vpropertyName,
    this._vleadByName,
    this._vcreatedByName,
    this._venquirySource,
    this._vdivisionId,
    this._vagentName,
    this._vdivisionCategoryName,
    this._vstatus,
    this._vcountryCode,
    this._vcountryName,
    this._vleadQualification,
    this._vstatusName,
    this._vname,
    this._vcityId,
    this._vlistsize,
    this._vshortName,
    this._finYear,
    this._cityId,
    this._inac_id,
    this._icpd_id,
    this._cityName,
    this._vpayment_term_name,
    this._vbillboard_location,
    this._vtax_no,
  );

  factory EnquiryList.fromJson(Map<String?, dynamic> json) => EnquiryList(
        json["id"],
        json["vcustomer_name"],
        json["vcustomer_address"],
        json["vpermanent_city"],
        json["vcustomer_mobile1"],
        json["vcustomer_mobile2"],
        json["vcustomer_email_address"],
        json["vcustomer_email_address2"],
        json["vproperty_enquiry_code"],
        json["vtemp_customer_code"],
        json["denquiry_date"],
        json["iproperty_id"],
        json["idivision_category_id"],
        json["ipayment_terms_id"],
        json["mour_offer"],
        json["ilead_source"],
        json["ibusiness_area_id"],
        json["vremarks"],
        json["vagent_code"],
        json["vlead_by"],
        json["vcreated_by"],
        json["dcreated_date"],
        json["vupdated_by"],
        json["dupdated_date"],
        json["cstatus"],
        json["cenquiry_status"],
        json["clead_qualification"],
        json["icountry_id"],
        json["ibillboard_location_id"],
        json["ienquiry_detail_id"],
        json["vcustomer_mobile"],
        json["venquiry_date"],
        json["vproperty_name"],
        json["vlead_by_name"],
        json["vcreated_by_name"],
        json["venquiry_source"],
        json["vdivision_id"],
        json["vagent_name"],
        json["vdivision_category_name"],
        json["vstatus"],
        json["vcountry_code"],
        json["vcountry_name"],
        json["vlead_qualification"],
        json["vstatus_name"],
        json["vname"],
        json["vcity_id"],
        json["vlistsize"],
        json["vshort_name"],
        json["fin_year"],
        json["icity_id"],
        json["inac_id"],
        json["icpd_id"],
        json["cityName"],
        json["vpayment_term_name"],
        json["vbillboard_location"],
        json["vtax_no"],
      );

  Map<String?, dynamic> toJson() => {
        "id": _id,
        "vcustomer_name": _vcustomerName,
        "vcustomer_address": _vcustomerAddress,
        "vpermanent_city": _vpermanentCity,
        "vcustomer_mobile1": _vcustomerMobile1,
        "vcustomer_mobile2": _vcustomerMobile2,
        "vcustomer_email_address": _vcustomerEmailAddress,
        "vcustomer_email_address2": _vcustomerEmailAddress2,
        "vproperty_enquiry_code": _vpropertyEnquiryCode,
        "vtemp_customer_code": _vtempCustomerCode,
        "denquiry_date": _denquiryDate,
        "iproperty_id": _ipropertyId,
        "idivision_category_id": _idivisionCategoryId,
        "ipayment_terms_id": _ipaymentTermsId,
        "mour_offer": _mourOffer,
        "ilead_source": _ileadSource,
        "ibusiness_area_id": _ibusinessAreaId,
        "vremarks": _vremarks,
        "vagent_code": _vagentCode,
        "vlead_by": _vleadBy,
        "vcreated_by": _vcreatedBy,
        "dcreated_date": _dcreatedDate,
        "vupdated_by": _vupdatedBy,
        "dupdated_date": _dupdatedDate,
        "cstatus": _cstatus,
        "cenquiry_status": _cenquiryStatus,
        "clead_qualification": _cleadQualification,
        "icountry_id": _icountryId,
        "ibillboard_location_id": _ibillboardLocationId,
        "ienquiry_detail_id": _ienquiryDetailId,
        "vcustomer_mobile": _vcustomerMobile,
        "venquiry_date": _venquiryDate,
        "vproperty_name": _vpropertyName,
        "vlead_by_name": _vleadByName,
        "vcreated_by_name": _vcreatedByName,
        "venquiry_source": _venquirySource,
        "vdivision_id": _vdivisionId,
        "vagent_name": _vagentName,
        "vdivision_category_name": _vdivisionCategoryName,
        "vstatus": _vstatus,
        "vcountry_code": _vcountryCode,
        "vcountry_name": _vcountryName,
        "vlead_qualification": _vleadQualification,
        "vstatus_name": _vstatusName,
        "vname": _vname,
        "vcity_id": _vcityId,
        "vlistsize": _vlistsize,
        "vshort_name": _vshortName,
        "fin_year": _finYear,
        "icity_id": _cityId,
        "inac_id": this._inac_id,
        "icpd_id": this._icpd_id,
        "cityName": this._cityName,
        "vpayment_term_name": this._vpayment_term_name,
        "vbillboard_location": this._vbillboard_location,
        "vcustomer_email_address2": this._vcustomerEmailAddress2,
        "vtax_no": this._vtax_no,
      };
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['vcustomer_name'] = this._vcustomerName;
    map['vcustomer_address'] = this._vcustomerAddress;
    map['vpermanent_city'] = this._vpermanentCity;
    map['vcustomer_mobile1'] = this._vcustomerMobile;
    map['vcustomer_mobile2'] = this._vcustomerMobile1;
    map['vcustomer_email_address'] = this._vcustomerEmailAddress;
    map['vcustomer_email_address2'] = this._vcustomerEmailAddress2;
    map['vproperty_enquiry_code'] = this._vpropertyEnquiryCode;
    map['vtemp_customer_code'] = this._vtempCustomerCode;
    map['denquiry_date'] = this._denquiryDate;
    map['iproperty_id'] = this._ipropertyId;
    map['ipayment_terms_id'] = this._ipaymentTermsId;
    map['mour_offer'] = this._mourOffer;
    map['ilead_source'] = this._ileadSource;
    map['vremarks'] = this._vremarks;
    map['vagent_code'] = this._vagentCode;
    map['vlead_by'] = this._vleadBy;
    map['fin_year'] = this._finYear;
    map['cenquiry_status'] = this._cenquiryStatus;
    map['clead_qualification'] = this._cleadQualification;
    map['icountry_id'] = this._icountryId;
    map['ibillboard_location_id'] = this._ibillboardLocationId;
    map['ienquiry_detail_id'] = this._ienquiryDetailId;
    map['vcreated_by'] = this._vcreatedBy;
    map['dcreated_date'] = this._denquiryDate;
    map['vupdated_by'] = this._vupdatedBy;
    map['dupdated_date'] = this._dupdatedDate;
    map['cstatus'] = this._cstatus;
    return map;
  }

  EnquiryList.fromMapObject(Map<String?, dynamic> map) {
    this._id = map['id'];
    this._vcustomerName = map['vcustomer_name'];
    this._vcustomerAddress = map['vcustomer_address'];
    this._vpermanentCity = map['vpermanent_city'];
    this._vcustomerMobile1 = map['vcustomer_mobile1'];
    this._vcustomerMobile2 = map['vcustomer_mobile2'];
    this._vcustomerEmailAddress = map['vcustomer_email_address'];
    this._vcustomerEmailAddress2 = map['vcustomer_email_address2'];
    this._vpropertyEnquiryCode = map['vproperty_enquiry_code'];
    this._vtempCustomerCode = map['vtemp_customer_code'];
    this._denquiryDate = map['denquiry_date'];
    this._ipropertyId = map['iproperty_id'];
    this._ipaymentTermsId = map['ipayment_terms_id'];
    this._mourOffer = double.parse(map['mour_offer']);
    this._ileadSource = map['ilead_source'];
    this._vremarks = map['vremarks'];
    this._vagentCode = map['vagent_code'];
    this._vleadBy = map['vlead_by'];
    this._finYear = map['fin_year'];
    this._cenquiryStatus = map['cenquiry_status'];
    this._cleadQualification = map['clead_qualification'];
    this._icountryId = map['icountry_id'];
    this._ibillboardLocationId = map['ibillboard_location_id'];
    this._ienquiryDetailId = map['ienquiry_detail_id'];
    this._vcreatedBy = map['vcreated_by'];
    this._vupdatedBy = map['vupdated_by'];
    this._dcreatedDate = map['dcreated_date'];
    this._dupdatedDate = map['dupdated_date'];
    this._cstatus = map['cstatus'];
    this._cstatus = map['cstatus'];
  }

  String? get cityName => _cityName;

  set cityName(String? value) {
    _cityName = value;
  }

  String? get finYear => _finYear;

  set finYear(String? value) {
    _finYear = value;
  }

  String? get vshortName => _vshortName;

  set vshortName(String? value) {
    _vshortName = value;
  }

  String? get vlistsize => _vlistsize;

  set vlistsize(String? value) {
    _vlistsize = value;
  }

  String? get vcityId => _vcityId;

  set vcityId(String? value) {
    _vcityId = value;
  }

  String? get vname => _vname;

  set vname(String? value) {
    _vname = value;
  }

  String? get vstatusName => _vstatusName;

  set vstatusName(String? value) {
    _vstatusName = value;
  }

  String? get vleadQualification => _vleadQualification;

  set vleadQualification(String? value) {
    _vleadQualification = value;
  }

  String? get vcountryName => _vcountryName;

  set vcountryName(String? value) {
    _vcountryName = value;
  }

  String? get vcountryCode => _vcountryCode;

  set vcountryCode(String? value) {
    _vcountryCode = value;
  }

  String? get vstatus => _vstatus;

  set vstatus(String? value) {
    _vstatus = value;
  }

  String? get vdivisionCategoryName => _vdivisionCategoryName;

  set vdivisionCategoryName(String? value) {
    _vdivisionCategoryName = value;
  }

  String? get vagentName => _vagentName;

  set vagentName(String? value) {
    _vagentName = value;
  }

  String? get vdivisionId => _vdivisionId;

  set vdivisionId(String? value) {
    _vdivisionId = value;
  }

  String? get venquirySource => _venquirySource;

  set venquirySource(String? value) {
    _venquirySource = value;
  }

  String? get vcreatedByName => _vcreatedByName;

  set vcreatedByName(String? value) {
    _vcreatedByName = value;
  }

  String? get vleadByName => _vleadByName;

  set vleadByName(String? value) {
    _vleadByName = value;
  }

  String? get vpropertyName => _vpropertyName;

  set vpropertyName(String? value) {
    _vpropertyName = value;
  }

  String? get venquiryDate => _venquiryDate;

  set venquiryDate(String? value) {
    _venquiryDate = value;
  }

  String? get vcustomerMobile => _vcustomerMobile;

  set vcustomerMobile(String? value) {
    _vcustomerMobile = value;
  }

  int get ienquiryDetailId => _ienquiryDetailId;

  set ienquiryDetailId(int value) {
    _ienquiryDetailId = value;
  }

  int get ibillboardLocationId => _ibillboardLocationId;

  set ibillboardLocationId(int value) {
    _ibillboardLocationId = value;
  }

  int get icountryId => _icountryId;

  set icountryId(int value) {
    _icountryId = value;
  }

  String? get cleadQualification => _cleadQualification;

  set cleadQualification(String? value) {
    _cleadQualification = value;
  }

  String? get cenquiryStatus => _cenquiryStatus;

  set cenquiryStatus(String? value) {
    _cenquiryStatus = value;
  }

  String? get cstatus => _cstatus;

  set cstatus(String? value) {
    _cstatus = value;
  }

  String? get dupdatedDate => _dupdatedDate;

  set dupdatedDate(String? value) {
    _dupdatedDate = value;
  }

  String? get vupdatedBy => _vupdatedBy;

  set vupdatedBy(String? value) {
    _vupdatedBy = value;
  }

  String? get dcreatedDate => _dcreatedDate;

  set dcreatedDate(String? value) {
    _dcreatedDate = value;
  }

  String? get vcreatedBy => _vcreatedBy;

  set vcreatedBy(String? value) {
    _vcreatedBy = value;
  }

  String? get vleadBy => _vleadBy;

  set vleadBy(String? value) {
    _vleadBy = value;
  }

  String? get vagentCode => _vagentCode;

  set vagentCode(String? value) {
    _vagentCode = value;
  }

  String? get vremarks => _vremarks;

  set vremarks(String? value) {
    _vremarks = value;
  }

  int? get ibusinessAreaId => _ibusinessAreaId;

  set ibusinessAreaId(int? value) {
    _ibusinessAreaId = value;
  }

  int get ileadSource => _ileadSource;

  set ileadSource(int value) {
    _ileadSource = value;
  }

  double get mourOffer => _mourOffer;

  set mourOffer(double value) {
    _mourOffer = value;
  }

  int get ipaymentTermsId => _ipaymentTermsId;

  set ipaymentTermsId(int value) {
    _ipaymentTermsId = value;
  }

  int? get idivisionCategoryId => _idivisionCategoryId;

  set idivisionCategoryId(int? value) {
    _idivisionCategoryId = 0;
  }

  int get ipropertyId => _ipropertyId;

  set ipropertyId(int value) {
    _ipropertyId = value;
  }

  String? get denquiryDate => _denquiryDate;

  set denquiryDate(String? value) {
    _denquiryDate = value;
  }

  String? get vtempCustomerCode => _vtempCustomerCode;

  set vtempCustomerCode(String? value) {
    _vtempCustomerCode = value;
  }

  String? get vpropertyEnquiryCode => _vpropertyEnquiryCode;

  set vpropertyEnquiryCode(String? value) {
    _vpropertyEnquiryCode = value;
  }

  String? get vcustomerEmailAddress2 => _vcustomerEmailAddress2;

  set vcustomerEmailAddress2(String? value) {
    _vcustomerEmailAddress2 = value;
  }

  String? get vcustomerEmailAddress => _vcustomerEmailAddress;

  set vcustomerEmailAddress(String? value) {
    _vcustomerEmailAddress = value;
  }

  String? get vcustomerMobile2 => _vcustomerMobile2;

  set vcustomerMobile2(String? value) {
    _vcustomerMobile2 = value;
  }

  String? get vcustomerMobile1 => _vcustomerMobile1;

  set vcustomerMobile1(String? value) {
    _vcustomerMobile1 = value;
  }

  String? get vpermanentCity => _vpermanentCity;

  set vpermanentCity(String? value) {
    _vpermanentCity = value;
  }

  String? get vcustomerAddress => _vcustomerAddress;

  set vcustomerAddress(String? value) {
    _vcustomerAddress = value;
  }

  String? get vcustomerName => _vcustomerName;

  set vcustomerName(String? value) {
    _vcustomerName = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  int? get cityId => _cityId;

  set cityId(int? value) {
    _cityId = value;
  }

  @override
  String toString() {
    return 'EnquiryList{_id: $_id, _vcustomerName: $_vcustomerName, _vcustomerAddress: $_vcustomerAddress, _vpermanentCity: $_vpermanentCity, _vcustomerMobile1: $_vcustomerMobile1, _vcustomerMobile2: $_vcustomerMobile2, _vcustomerEmailAddress: $_vcustomerEmailAddress, _vcustomerEmailAddress2: $_vcustomerEmailAddress2, _vpropertyEnquiryCode: $_vpropertyEnquiryCode, _vtempCustomerCode: $_vtempCustomerCode, _denquiryDate: $_denquiryDate, _ipropertyId: $_ipropertyId, _idivisionCategoryId: $_idivisionCategoryId, _ipaymentTermsId: $_ipaymentTermsId, _mourOffer: $_mourOffer, _ileadSource: $_ileadSource, _ibusinessAreaId: $_ibusinessAreaId, _vremarks: $_vremarks, _vagentCode: $_vagentCode, _vleadBy: $_vleadBy, _vcreatedBy: $_vcreatedBy, _dcreatedDate: $_dcreatedDate, _vupdatedBy: $_vupdatedBy, _dupdatedDate: $_dupdatedDate, _cstatus: $_cstatus, _cenquiryStatus: $_cenquiryStatus, _cleadQualification: $_cleadQualification, _icountryId: $_icountryId, _ibillboardLocationId: $_ibillboardLocationId, _ienquiryDetailId: $_ienquiryDetailId, _vcustomerMobile: $_vcustomerMobile, _venquiryDate: $_venquiryDate, _vpropertyName: $_vpropertyName, _vleadByName: $_vleadByName, _vcreatedByName: $_vcreatedByName, _venquirySource: $_venquirySource, _vdivisionId: $_vdivisionId, _vagentName: $_vagentName, _vdivisionCategoryName: $_vdivisionCategoryName, _vstatus: $_vstatus, _vcountryCode: $_vcountryCode, _vcountryName: $_vcountryName, _vleadQualification: $_vleadQualification, _vstatusName: $_vstatusName, _vname: $_vname, _vcityId: $_vcityId, _vlistsize: $_vlistsize, _vshortName: $_vshortName, _finYear: $_finYear}';
  }

  String? get vpayment_term_name => _vpayment_term_name;

  set vpayment_term_name(String? value) {
    _vpayment_term_name = value;
  }

  String? get vbillboard_location => _vbillboard_location;

  set vbillboard_location(String? value) {
    _vbillboard_location = value;
  }

  String? get vtax_no => _vtax_no;

  set vtax_no(String? value) {
    _vtax_no = value;
  }

  int? get inac_id => _inac_id;

  set inac_id(int? value) {
    _inac_id = value;
  }

  int? get icpd_id => _icpd_id;

  set icpd_id(int? value) {
    _icpd_id = value;
  }
}
