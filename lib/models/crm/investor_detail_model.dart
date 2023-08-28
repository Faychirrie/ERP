// To parse this JSON data, do
//
//     final investorDetailModel = investorDetailModelFromJson(jsonString);

import 'dart:convert';

InvestorDetailModel investorDetailModelFromJson(String str) =>
    InvestorDetailModel.fromJson(json.decode(str));

String? investorDetailModelToJson(InvestorDetailModel data) =>
    json.encode(data.toJson());

class InvestorDetailModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<InvestorList> investorList;

  InvestorDetailModel({
    this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    this.cstatus,
    required this.investorList,
  });

  factory InvestorDetailModel.fromJson(Map<String, dynamic> json) =>
      InvestorDetailModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        investorList: List<InvestorList>.from(
            json["detailList"].map((x) => InvestorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "detailList": List<dynamic>.from(investorList.map((x) => x.toJson())),
      };
}

class InvestorList {
  int? id;
  int? ifloorId;
  String? vfloorName;
  String? vpropertyName;
  String? vdivisionCategoryName;
  String? vpropertyCategoryName;
  int? ipropertyId;
  int? ipropertyCategoryId;
  int? isetupId;
  int? idivisionCategoryId;
  String? vsetupName;
  String? cbookingStatus;
  String? ccurrentStatus;
  String? vplantName;
  String? vcustomerName;
  String? vcustomerCode;
  String? vplantCode;
  double? mdealAmount;
  double? noOfUnits;
  String? cstatus;

  InvestorList({
    this.id,
    this.ifloorId,
    this.vfloorName,
    this.vpropertyName,
    this.vdivisionCategoryName,
    this.vpropertyCategoryName,
    this.ipropertyId,
    this.ipropertyCategoryId,
    this.isetupId,
    this.idivisionCategoryId,
    this.vsetupName,
    this.cbookingStatus,
    this.ccurrentStatus,
    this.vplantName,
    this.vcustomerName,
    this.vcustomerCode,
    this.vplantCode,
    this.mdealAmount,
    this.noOfUnits,
    this.cstatus,
  });

  factory InvestorList.fromJson(Map<String, dynamic> json) => InvestorList(
        id: json["id"],
        ifloorId: json["ifloor_id"],
        vfloorName: json["vfloor_name"],
        vpropertyName: json["vproperty_name"],
        vdivisionCategoryName: json["vdivision_category_name"],
        vpropertyCategoryName: json["vproperty_category_name"],
        ipropertyId: json["iproperty_id"],
        ipropertyCategoryId: json["iproperty_category_id"],
        isetupId: json["isetup_id"],
        idivisionCategoryId: json["idivision_category_id"],
        vsetupName: json["vsetup_name"],
        cbookingStatus: json["cbooking_status"],
        ccurrentStatus: json["ccurrent_status"],
        vplantName: json["vplant_name"],
        vcustomerName: json["vcustomer_name"],
        vcustomerCode: json["vcustomer_code"],
        vplantCode: json["vplant_code"],
        mdealAmount: json["mdeal_amount"],
        noOfUnits: json["no_of_units"],
        cstatus: json["cstatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ifloor_id": ifloorId,
        "vfloor_name": vfloorName,
        "vproperty_name": vpropertyName,
        "vdivision_category_name": vdivisionCategoryName,
        "vproperty_category_name": vpropertyCategoryName,
        "iproperty_id": ipropertyId,
        "iproperty_category_id": ipropertyCategoryId,
        "isetup_id": isetupId,
        "idivision_category_id": idivisionCategoryId,
        "vsetup_name": vsetupName,
        "cbooking_status": cbookingStatus,
        "ccurrent_status": ccurrentStatus,
        "vplant_name": vplantName,
        "vcustomer_name": vcustomerName,
        "vcustomer_code": vcustomerCode,
        "vplant_code": vplantCode,
        "mdeal_amount": mdealAmount,
        "no_of_units": noOfUnits,
        "cstatus": cstatus,
      };
}
