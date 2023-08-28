// To parse this JSON data, do
//
//     final businessAreaModel = businessAreaModelFromJson(jsonString);

import 'dart:convert';

BusinessAreaModel businessAreaModelFromJson(String str) => BusinessAreaModel.fromJson(json.decode(str));

String ?businessAreaModelToJson(BusinessAreaModel data) => json.encode(data.toJson());

class BusinessAreaModel {
  String ?vstatusRemarks;
  String ?vtransactionCode;
  String ?vqueryResult;
  String ?cstatus;
  List<BusinessAreaList> businessAreaList;

  BusinessAreaModel({
    this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    this.cstatus,
    required this.businessAreaList,
  });

  factory BusinessAreaModel.fromJson(Map<String, dynamic> json) => BusinessAreaModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    businessAreaList: List<BusinessAreaList>.from(json["detailList"].map((x) => BusinessAreaList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "detailList": List<dynamic>.from(businessAreaList.map((x) => x.toJson())),
  };
}

class BusinessAreaList {
  int ?ibusinessAreaId;
  String ?vbusinessAreaName;
  String ?vbusinessAreaCode;
  String ?vbusinessAreaAddress;
  String ? vbusinessAreaInchargeCode;
  String ?vbusinessAreaDescription;
  String ?vbusinessAreaContact;
  String ?vbusinessAreaEmailId;
  String ?vshortName;
  String ?cdefaultType;
  int ?icompanyId;
  String ?vcontactPerson;
  String ?vcontactPersonMobile;
  String ?callowNeagtiveStockSale;
  String ?callowWarehouseStockSale;
  String ?callowPoEditAfterApproval;
  String ?callowSoEditAfterApproval;
  String ?callowVatSales;
  String ?callowDiscountSales;
  String ?callowRateSales;
  String ?vpurchaseContactPersonCode;
  String ?vpurchaseContactPersonEmail;
  String ?vsalesContactPersonEmail;
  String ?vsalesContactPersonCode;
  String ?vaccountContactPersonEmail;
  String ?vaccountContactPersonCode;
  String ?vfaxNo;
  String ?vcompanyFax;
  String ?companyPan;
  String ?companyTin;
  String ?vcompanyWebsite;
  String ?vcompanyPincode;
  String ?vcompanyContact1;
  String ?vcompanyContact2;
  String ?vcompanyShortName;
  String ?vcompanyEmail;
  String ?vcompanyCity;
  String ?vcompanyState;
  String ?vcompanyCountry;
  String ?companyAddress;
  String ?vcompanyName;
  String ?vlogoUrl;
  String ?vexcelUrl;
  String ?cstatus;
  String ?ctype;
  String ?dcreatedDate;
  String ?dupdatedDate;
  String ?vcreatedBy;
  String ?vupdatedBy;

  BusinessAreaList({
    this.ibusinessAreaId,
    this.vbusinessAreaName,
    this.vbusinessAreaCode,
    this.vbusinessAreaAddress,
    this.vbusinessAreaInchargeCode,
    this.vbusinessAreaDescription,
    this.vbusinessAreaContact,
    this.vbusinessAreaEmailId,
    this.vshortName,
    this.cdefaultType,
    this.icompanyId,
    this.vcontactPerson,
    this.vcontactPersonMobile,
    this.callowNeagtiveStockSale,
    this.callowWarehouseStockSale,
    this.callowPoEditAfterApproval,
    this.callowSoEditAfterApproval,
    this.callowVatSales,
    this.callowDiscountSales,
    this.callowRateSales,
    this.vpurchaseContactPersonCode,
    this.vpurchaseContactPersonEmail,
    this.vsalesContactPersonEmail,
    this.vsalesContactPersonCode,
    this.vaccountContactPersonEmail,
    this.vaccountContactPersonCode,
    this.vfaxNo,
    this.vcompanyFax,
    this.companyPan,
    this.companyTin,
    this.vcompanyWebsite,
    this.vcompanyPincode,
    this.vcompanyContact1,
    this.vcompanyContact2,
    this.vcompanyShortName,
    this.vcompanyEmail,
    this.vcompanyCity,
    this.vcompanyState,
    this.vcompanyCountry,
    this.companyAddress,
    this.vcompanyName,
    this.vlogoUrl,
    this.vexcelUrl,
    this.cstatus,
    this.ctype,
    this.dcreatedDate,
    this.dupdatedDate,
    this.vcreatedBy,
    this.vupdatedBy,
  });

  factory BusinessAreaList.fromJson(Map<String, dynamic> json) => BusinessAreaList(
    ibusinessAreaId: json["ibusiness_area_id"],
    vbusinessAreaName: json["vbusiness_area_name"],
    vbusinessAreaCode: json["vbusiness_area_code"],
    vbusinessAreaAddress: json["vbusiness_area_address"],
    vbusinessAreaInchargeCode: json["vbusiness_area_incharge_code"],
    vbusinessAreaDescription: json["vbusiness_area_description"],
    vbusinessAreaContact: json["vbusiness_area_contact"],
    vbusinessAreaEmailId: json["vbusiness_area_email_id"],
    vshortName: json["vshort_name"],
    cdefaultType: json["cdefault_type"],
    icompanyId: json["icompany_id"],
    vcontactPerson: json["vcontact_person"],
    vcontactPersonMobile: json["vcontact_person_mobile"],
    callowNeagtiveStockSale: json["callow_neagtive_stock_sale"],
    callowWarehouseStockSale: json["callow_warehouse_stock_sale"],
    callowPoEditAfterApproval: json["callow_po_edit_after_approval"],
    callowSoEditAfterApproval: json["callow_so_edit_after_approval"],
    callowVatSales: json["callow_vat_sales"],
    callowDiscountSales: json["callow_discount_sales"],
    callowRateSales: json["callow_rate_sales"],
    vpurchaseContactPersonCode: json["vpurchase_contact_person_code"],
    vpurchaseContactPersonEmail: json["vpurchase_contact_person_email"],
    vsalesContactPersonEmail: json["vsales_contact_person_email"],
    vsalesContactPersonCode: json["vsales_contact_person_code"],
    vaccountContactPersonEmail: json["vaccount_contact_person_email"],
    vaccountContactPersonCode: json["vaccount_contact_person_code"],
    vfaxNo: json["vfax_no"],
    vcompanyFax: json["vcompany_fax"],
    companyPan: json["company_pan"],
    companyTin: json["company_tin"],
    vcompanyWebsite: json["vcompany_website"],
    vcompanyPincode: json["vcompany_pincode"],
    vcompanyContact1: json["vcompany_contact_1"],
    vcompanyContact2: json["vcompany_contact_2"],
    vcompanyShortName: json["vcompany_short_name"],
    vcompanyEmail: json["vcompany_email"],
    vcompanyCity: json["vcompany_city"],
    vcompanyState: json["vcompany_state"],
    vcompanyCountry: json["vcompany_country"],
    companyAddress: json["company_address"],
    vcompanyName: json["vcompany_name"],
    vlogoUrl: json["vlogo_url"],
    vexcelUrl: json["vexcel_url"],
    cstatus: json["cstatus"],
    ctype: json["ctype"],
    dcreatedDate: json["dcreated_date"],
    dupdatedDate: json["dupdated_date"],
    vcreatedBy: json["vcreated_by"],
    vupdatedBy: json["vupdated_by"],
  );

  Map<String, dynamic> toJson() => {
    "ibusiness_area_id": ibusinessAreaId,
    "vbusiness_area_name": vbusinessAreaName,
    "vbusiness_area_code": vbusinessAreaCode,
    "vbusiness_area_address": vbusinessAreaAddress,
    "vbusiness_area_incharge_code": vbusinessAreaInchargeCode,
    "vbusiness_area_description": vbusinessAreaDescription,
    "vbusiness_area_contact": vbusinessAreaContact,
    "vbusiness_area_email_id": vbusinessAreaEmailId,
    "vshort_name": vshortName,
    "cdefault_type": cdefaultType,
    "icompany_id": icompanyId,
    "vcontact_person": vcontactPerson,
    "vcontact_person_mobile": vcontactPersonMobile,
    "callow_neagtive_stock_sale": callowNeagtiveStockSale,
    "callow_warehouse_stock_sale": callowWarehouseStockSale,
    "callow_po_edit_after_approval": callowPoEditAfterApproval,
    "callow_so_edit_after_approval": callowSoEditAfterApproval,
    "callow_vat_sales": callowVatSales,
    "callow_discount_sales": callowDiscountSales,
    "callow_rate_sales": callowRateSales,
    "vpurchase_contact_person_code": vpurchaseContactPersonCode,
    "vpurchase_contact_person_email": vpurchaseContactPersonEmail,
    "vsales_contact_person_email": vsalesContactPersonEmail,
    "vsales_contact_person_code": vsalesContactPersonCode,
    "vaccount_contact_person_email": vaccountContactPersonEmail,
    "vaccount_contact_person_code": vaccountContactPersonCode,
    "vfax_no": vfaxNo,
    "vcompany_fax": vcompanyFax,
    "company_pan": companyPan,
    "company_tin": companyTin,
    "vcompany_website": vcompanyWebsite,
    "vcompany_pincode": vcompanyPincode,
    "vcompany_contact_1": vcompanyContact1,
    "vcompany_contact_2": vcompanyContact2,
    "vcompany_short_name": vcompanyShortName,
    "vcompany_email": vcompanyEmail,
    "vcompany_city": vcompanyCity,
    "vcompany_state": vcompanyState,
    "vcompany_country": vcompanyCountry,
    "company_address": companyAddress,
    "vcompany_name": vcompanyName,
    "vlogo_url": vlogoUrl,
    "vexcel_url": vexcelUrl,
    "cstatus": cstatus,
    "ctype": ctype,
    "dcreated_date": dcreatedDate,
    "dupdated_date": dupdatedDate,
    "vcreated_by": vcreatedBy,
    "vupdated_by": vupdatedBy,
  };
}
