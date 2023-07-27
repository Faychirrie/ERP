// To parse this JSON data, do
//
//     final newActivityCustomerMasterModel = newActivityCustomerMasterModelFromJson(jsonString);

import 'dart:convert';

NewActivityCustomerMasterModel newActivityCustomerMasterModelFromJson(String str) => NewActivityCustomerMasterModel.fromJson(json.decode(str));

String newActivityCustomerMasterModelToJson(NewActivityCustomerMasterModel data) => json.encode(data.toJson());

class NewActivityCustomerMasterModel {
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  String cstatus;
  List<CustomerList> customerList;

  NewActivityCustomerMasterModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.cstatus,
    required this.customerList,
  });

  factory NewActivityCustomerMasterModel.fromJson(Map<String, dynamic> json) => NewActivityCustomerMasterModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cstatus: json["cstatus"],
    customerList: List<CustomerList>.from(json["customerList"].map((x) => CustomerList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "cstatus": cstatus,
    "customerList": List<dynamic>.from(customerList.map((x) => x.toJson())),
  };
}

class CustomerList {
  int id;
  String vplantCode;
  String vplantName;
  String vcustomerPlantAddress;
  String vcustomerPlantCountry;
  String vpermanentState;
  String vcustomerTahsil;
  String vcustomerPlantPincode;
  String vpermanentCity;
  String vregion;
  String vcustomerFax;
  String vcustomerPlantEmail;
  String vcustomerPlantContactperson1;
  String vcontactPerson1Des;
  String vcustomerPlantContactperson2;
  String vcontactPerson2Des;
  String vcustomerPlantPh1;
  String vcustomerPlantPh2;
  String vcustomerPlantWebsite;
  String vcustomerType;
  String vclientCreated;
  String vtimeIn;
  String vtimeOut;
  String cstatus;
  String cTaxType;
  int icityId;
  int icurrencyId;
  String vtinNo;
  String vofficeContactNo;
  String vmarketingEngineerCode;
  String vcreatedBy;
  String dcreatedDate;
  String vupdatedBy;
  String dupdatedDate;
  String vcustomerPlantMob1;
  String vcustomerPlantMob2;
  int icompanyId;
  String vcompanyShortName;
  String vuserPlantCode;
  int ibusinessAreaId;

  CustomerList({
    required this.id,
    required this.vplantCode,
    required this.vplantName,
    required this.vcustomerPlantAddress,
    required this.vcustomerPlantCountry,
    required this.vpermanentState,
    required this.vcustomerTahsil,
    required this.vcustomerPlantPincode,
    required this.vpermanentCity,
    required this.vregion,
    required this.vcustomerFax,
    required this.vcustomerPlantEmail,
    required this.vcustomerPlantContactperson1,
    required this.vcontactPerson1Des,
    required this.vcustomerPlantContactperson2,
    required this.vcontactPerson2Des,
    required this.vcustomerPlantPh1,
    required this.vcustomerPlantPh2,
    required this.vcustomerPlantWebsite,
    required this.vcustomerType,
    required this.vclientCreated,
    required this.vtimeIn,
    required this.vtimeOut,
    required this.cstatus,
    required this.cTaxType,
    required this.icityId,
    required this.icurrencyId,
    required this.vtinNo,
    required this.vofficeContactNo,
    required this.vmarketingEngineerCode,
    required this.vcreatedBy,
    required this.dcreatedDate,
    required this.vupdatedBy,
    required this.dupdatedDate,
    required this.vcustomerPlantMob1,
    required this.vcustomerPlantMob2,
    required this.icompanyId,
    required this.vcompanyShortName,
    required this.vuserPlantCode,
    required this.ibusinessAreaId,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    id: json["id"],
    vplantCode: json["vplant_code"],
    vplantName: json["vplant_name"],
    vcustomerPlantAddress: json["vcustomer_plant_address"],
    vcustomerPlantCountry: json["vcustomer_plant_country"],
    vpermanentState: json["vpermanent_state"],
    vcustomerTahsil: json["vcustomer_tahsil"],
    vcustomerPlantPincode: json["vcustomer_plant_pincode"],
    vpermanentCity: json["vpermanent_city"],
    vregion: json["vregion"],
    vcustomerFax: json["vcustomer_fax"],
    vcustomerPlantEmail: json["vcustomer_plant_email"],
    vcustomerPlantContactperson1: json["vcustomer_plant_contactperson1"],
    vcontactPerson1Des: json["vcontact_person1_des"],
    vcustomerPlantContactperson2: json["vcustomer_plant_contactperson2"],
    vcontactPerson2Des: json["vcontact_person2_des"],
    vcustomerPlantPh1: json["vcustomer_plant_ph1"],
    vcustomerPlantPh2: json["vcustomer_plant_ph2"],
    vcustomerPlantWebsite: json["vcustomer_plant_website"],
    vcustomerType: json["vcustomer_type"],
    vclientCreated: json["vclient_created"],
    vtimeIn: json["vtime_in"],
    vtimeOut: json["vtime_out"],
    cstatus: json["cstatus"],
    cTaxType: json["cTax_type"],
    icityId: json["icity_id"],
    icurrencyId: json["icurrency_id"],
    vtinNo: json["vtin_no"],
    vofficeContactNo: json["voffice_contact_no"],
    vmarketingEngineerCode: json["vmarketing_engineer_code"],
    vcreatedBy: json["vcreated_by"],
    dcreatedDate: json["dcreated_date"],
    vupdatedBy: json["vupdated_by"],
    dupdatedDate: json["dupdated_date"],
    vcustomerPlantMob1: json["vcustomer_plant_mob1"],
    vcustomerPlantMob2: json["vcustomer_plant_mob2"],
    icompanyId: json["icompany_id"],
    vcompanyShortName: json["vcompany_short_name"],
    vuserPlantCode: json["vuser_plant_code"],
    ibusinessAreaId: json["ibusiness_area_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vplant_code": vplantCode,
    "vplant_name": vplantName,
    "vcustomer_plant_address": vcustomerPlantAddress,
    "vcustomer_plant_country": vcustomerPlantCountry,
    "vpermanent_state": vpermanentState,
    "vcustomer_tahsil": vcustomerTahsil,
    "vcustomer_plant_pincode": vcustomerPlantPincode,
    "vpermanent_city": vpermanentCity,
    "vregion": vregion,
    "vcustomer_fax": vcustomerFax,
    "vcustomer_plant_email": vcustomerPlantEmail,
    "vcustomer_plant_contactperson1": vcustomerPlantContactperson1,
    "vcontact_person1_des": vcontactPerson1Des,
    "vcustomer_plant_contactperson2": vcustomerPlantContactperson2,
    "vcontact_person2_des": vcontactPerson2Des,
    "vcustomer_plant_ph1": vcustomerPlantPh1,
    "vcustomer_plant_ph2": vcustomerPlantPh2,
    "vcustomer_plant_website": vcustomerPlantWebsite,
    "vcustomer_type": vcustomerType,
    "vclient_created": vclientCreated,
    "vtime_in": vtimeIn,
    "vtime_out": vtimeOut,
    "cstatus": cstatus,
    "cTax_type": cTaxType,
    "icity_id": icityId,
    "icurrency_id": icurrencyId,
    "vtin_no": vtinNo,
    "voffice_contact_no": vofficeContactNo,
    "vmarketing_engineer_code": vmarketingEngineerCode,
    "vcreated_by": vcreatedBy,
    "dcreated_date": dcreatedDate,
    "vupdated_by": vupdatedBy,
    "dupdated_date": dupdatedDate,
    "vcustomer_plant_mob1": vcustomerPlantMob1,
    "vcustomer_plant_mob2": vcustomerPlantMob2,
    "icompany_id": icompanyId,
    "vcompany_short_name": vcompanyShortName,
    "vuser_plant_code": vuserPlantCode,
    "ibusiness_area_id": ibusinessAreaId,
  };
}
