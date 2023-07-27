// To parse this JSON data, do
//
//     final propertyUnitsModel = propertyUnitsModelFromJson(jsonString);

import 'dart:convert';

PropertyUnitsModel propertyUnitsModelFromJson(String str) =>
    PropertyUnitsModel.fromJson(json.decode(str));

String propertyUnitsModelToJson(PropertyUnitsModel data) =>
    json.encode(data.toJson());

class PropertyUnitsModel {
  String? vstatusRemarks;
  String? vtransactionCode;
  String? vqueryResult;
  String? cstatus;
  List<UnitList> unitList;

  PropertyUnitsModel({
    this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    this.cstatus,
    required this.unitList,
  });

  factory PropertyUnitsModel.fromJson(Map<String, dynamic> json) =>
      PropertyUnitsModel(
        vstatusRemarks: json["vstatus_remarks"],
        vtransactionCode: json["vtransaction_code"],
        vqueryResult: json["vquery_result"],
        cstatus: json["cstatus"],
        unitList: List<UnitList>.from(
            json["detailList"].map((x) => UnitList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vstatus_remarks": vstatusRemarks,
        "vtransaction_code": vtransactionCode,
        "vquery_result": vqueryResult,
        "cstatus": cstatus,
        "detailList": List<dynamic>.from(unitList.map((x) => x.toJson())),
      };
}

class UnitList {
  int id;
  int ifloorId;
  String? vfloorName;
  String? vpropertyName;
  String? vdivisionCategoryName;
  String? vpropertyCategoryName;
  int ipropertyId;
  int ipropertyCategoryId;
  int isetupId;
  int idivisionCategoryId;
  String? vsetupName;
  String cbookingStatus;
  String ccurrentStatus;
  String? vplantName;
  dynamic vcustomerName;

  UnitList({
    required this.id,
    required this.ifloorId,
    this.vfloorName,
    this.vpropertyName,
    this.vdivisionCategoryName,
    this.vpropertyCategoryName,
    required this.ipropertyId,
    required this.ipropertyCategoryId,
    required this.isetupId,
    required this.idivisionCategoryId,
    this.vsetupName,
    required this.cbookingStatus,
    required this.ccurrentStatus,
    this.vplantName,
    this.vcustomerName,
  });

  factory UnitList.fromJson(Map<String, dynamic> json) => UnitList(
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
      };

  @override
  String toString() {
    return 'UnitList{id: $id, ifloorId: $ifloorId, vfloorName: $vfloorName, vpropertyName: $vpropertyName, vdivisionCategoryName: $vdivisionCategoryName, vpropertyCategoryName: $vpropertyCategoryName, ipropertyId: $ipropertyId, ipropertyCategoryId: $ipropertyCategoryId, isetupId: $isetupId, idivisionCategoryId: $idivisionCategoryId, vsetupName: $vsetupName, cbookingStatus: $cbookingStatus, ccurrentStatus: $ccurrentStatus, vplantName: $vplantName, vcustomerName: $vcustomerName}';
  }
}
