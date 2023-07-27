// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString?);

import 'dart:convert';

MenuModel menuModelFromJson(String? str) => MenuModel.fromJson(json.decode(str!));

String? menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
     this.id,
     this.vempCode,
     this.vempName,
     this.vbusinessAreaShortCode,
     this.vloginName,
     this.vpassword,
     this.password,
     this.vbusinessAreaName,
     this.vstatusRemarks,
     this.imaxBackDays,
     this.ibusinessAreaId,
     this.imaxPostDays,
     this.iclientId,
     this.cstatus,
     this.cfiscalYearCloseEffect,
     required this.menuList,
     this.authToken,
     this.vclientName,
     this.vclientShortCode,
  });

  int?id;
  String? vempCode;
  String? vempName;
  String? vbusinessAreaShortCode;
  String? vloginName;
  String? vpassword;
  String? password;
  String? vbusinessAreaName;
  String? vstatusRemarks;
  int?imaxBackDays;
  int?ibusinessAreaId;
  int?imaxPostDays;
  int?iclientId;
  String? cstatus;
  String? cfiscalYearCloseEffect;
  List<MenuList> menuList;
  String? authToken;
  String? vclientName;
  String? vclientShortCode;

  factory MenuModel.fromJson(Map<String?, dynamic> json) => MenuModel(
    id: json["id"],
    vempCode: json["vemp_code"],
    vempName: json["vemp_name"],
    vbusinessAreaShortCode: json["vbusiness_area_short_code"],
    vloginName: json["vlogin_name"],
    vpassword: json["vpassword"],
    password: json["password"],
    vbusinessAreaName: json["vbusiness_area_name"],
    vstatusRemarks: json["vstatus_remarks"],
    imaxBackDays: json["imax_back_days"],
    ibusinessAreaId: json["ibusiness_area_id"],
    imaxPostDays: json["imax_post_days"],
    iclientId: json["iclient_id"],
    cstatus: json["cstatus"],
    cfiscalYearCloseEffect: json["cfiscal_year_close_effect"],
    menuList: List<MenuList>.from(json["menuList"].map((x) => MenuList.fromJson(x))),
    authToken: json["auth_token"],
    vclientName: json["vclient_name"],
    vclientShortCode: json["vclient_short_code"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "vemp_code": vempCode,
    "vemp_name": vempName,
    "vbusiness_area_short_code": vbusinessAreaShortCode,
    "vlogin_name": vloginName,
    "vpassword": vpassword,
    "password": password,
    "vbusiness_area_name": vbusinessAreaName,
    "vstatus_remarks": vstatusRemarks,
    "imax_back_days": imaxBackDays,
    "ibusiness_area_id": ibusinessAreaId,
    "imax_post_days": imaxPostDays,
    "iclient_id": iclientId,
    "cstatus": cstatus,
    "cfiscal_year_close_effect": cfiscalYearCloseEffect,
    "menuList": List<dynamic>.from(menuList.map((x) => x.toJson())),
    "auth_token": authToken,
    "vclient_name": vclientName,
    "vclient_short_code": vclientShortCode,
  };

  @override
  String toString() {
    return 'MenuModel{id: $id, vempCode: $vempCode, vempName: $vempName, vbusinessAreaShortCode: $vbusinessAreaShortCode, vloginName: $vloginName, vpassword: $vpassword, password: $password, vbusinessAreaName: $vbusinessAreaName, vstatusRemarks: $vstatusRemarks, imaxBackDays: $imaxBackDays, ibusinessAreaId: $ibusinessAreaId, imaxPostDays: $imaxPostDays, iclientId: $iclientId, cstatus: $cstatus, cfiscalYearCloseEffect: $cfiscalYearCloseEffect, menuList: $menuList, authToken: $authToken, vclientName: $vclientName, vclientShortCode: $vclientShortCode}';
  }
}

class MenuList {
  MenuList({
     this.mainMenuId,
     this.vmenuName,
     this.vdescription,
     this.vpath,
     this.vsubPath,
     this.vstate,
     this.ideviceType,
     this.imainMenuPriority,
     required this.menuActionList,
     this.subMenuList,
  });

  int?mainMenuId;
  String? vmenuName;
  String? vdescription;
  String? vpath;
  String? vsubPath;
  String? vstate;
  int?ideviceType;
  int?imainMenuPriority;
  List<MenuActionList> menuActionList;
  String? subMenuList;

  factory MenuList.fromJson(Map<String?, dynamic> json) => MenuList(
    mainMenuId: json["main_menu_id"],
    vmenuName: json["vmenu_name"],
    vdescription: json["vdescription"],
    vpath: json["vpath"],
    vsubPath: json["vsub_path"],
    vstate: json["vstate"],
    ideviceType: json["idevice_type"],
    imainMenuPriority: json["imain_menu_priority"],
    menuActionList: List<MenuActionList>.from(json["menuActionList"].map((x) => MenuActionList.fromJson(x))),
    subMenuList: json["subMenuList"],
  );

  Map<String?, dynamic> toJson() => {
    "main_menu_id": mainMenuId,
    "vmenu_name": vmenuName,
    "vdescription": vdescription,
    "vpath": vpath,
    "vsub_path": vsubPath,
    "vstate": vstate,
    "idevice_type": ideviceType,
    "imain_menu_priority": imainMenuPriority,
    "menuActionList": List<dynamic>.from(menuActionList.map((x) => x.toJson())),
    "subMenuList": subMenuList,
  };

  @override
  String toString() {
    return 'MenuList{mainMenuId: $mainMenuId, vmenuName: $vmenuName, vdescription: $vdescription, vpath: $vpath, vsubPath: $vsubPath, vstate: $vstate, ideviceType: $ideviceType, imainMenuPriority: $imainMenuPriority, menuActionList: $menuActionList, subMenuList: $subMenuList}';
  }
}

class MenuActionList {
  MenuActionList({
     this.id,
     this.vmoduleId,
     this.vempCode,
     this.iuserPriority,
     this.cpermAdd,
     this.cpermEdit,
     this.cpermDel,
     this.cpermView,
     this.cpermPrint,
     this.vsubmenuName,
     this.vmoduleName,
     this.dcreatedDate,
     this.vcreatedBy,
     this.vmenuName,
     this.vempName,
     this.department,
     this.designation,
     this.mainMenuId,
     this.subMenuId,
     this.vloginName,
     this.vpassword,
     this.vfileUrl,
     this.cactionType,
  });

  int?id;
  String? vmoduleId;
  String? vempCode;
  int?iuserPriority;
  String? cpermAdd;
  String? cpermEdit;
  String? cpermDel;
  String? cpermView;
  String? cpermPrint;
  String? vsubmenuName;
  String? vmoduleName;
  String? dcreatedDate;
  String? vcreatedBy;
  String? vmenuName;
  String? vempName;
  String? department;
  String? designation;
  int?mainMenuId;
  int?subMenuId;
  String? vloginName;
  String? vpassword;
  String? vfileUrl;
  String? cactionType;

  factory MenuActionList.fromJson(Map<String?, dynamic> json) => MenuActionList(
    id: json["id"],
    vmoduleId: json["vmodule_id"],
    vempCode: json["vemp_code"],
    iuserPriority: json["iuser_priority"],
    cpermAdd: json["cperm_add"],
    cpermEdit: json["cperm_edit"],
    cpermDel: json["cperm_del"],
    cpermView: json["cperm_view"],
    cpermPrint: json["cperm_print"],
    vsubmenuName: json["vsubmenu_name"],
    vmoduleName: json["vmodule_name"],
    dcreatedDate: json["dcreated_date"],
    vcreatedBy: json["vcreated_by"],
    vmenuName: json["vmenu_name"],
    vempName: json["vemp_name"],
    department: json["department"],
    designation: json["designation"],
    mainMenuId: json["main_menu_id"],
    subMenuId: json["sub_menu_id"],
    vloginName: json["vlogin_name"],
    vpassword: json["vpassword"],
    vfileUrl: json["vfile_url"],
    cactionType: json["caction_type"],
  );

  Map<String?, dynamic> toJson() => {
    "id": id,
    "vmodule_id": vmoduleId,
    "vemp_code": vempCode,
    "iuser_priority": iuserPriority,
    "cperm_add": cpermAdd,
    "cperm_edit": cpermEdit,
    "cperm_del": cpermDel,
    "cperm_view": cpermView,
    "cperm_print": cpermPrint,
    "vsubmenu_name": vsubmenuName,
    "vmodule_name": vmoduleName,
    "dcreated_date": dcreatedDate,
    "vcreated_by": vcreatedBy,
    "vmenu_name": vmenuName,
    "vemp_name": vempName,
    "department": department,
    "designation": designation,
    "main_menu_id": mainMenuId,
    "sub_menu_id": subMenuId,
    "vlogin_name": vloginName,
    "vpassword": vpassword,
    "vfile_url": vfileUrl,
    "caction_type": cactionType,
  };

  @override
  String toString() {
    return 'MenuActionList{id: $id, vmoduleId: $vmoduleId, vempCode: $vempCode, iuserPriority: $iuserPriority, cpermAdd: $cpermAdd, cpermEdit: $cpermEdit, cpermDel: $cpermDel, cpermView: $cpermView, cpermPrint: $cpermPrint, vsubmenuName: $vsubmenuName, vmoduleName: $vmoduleName, dcreatedDate: $dcreatedDate, vcreatedBy: $vcreatedBy, vmenuName: $vmenuName, vempName: $vempName, department: $department, designation: $designation, mainMenuId: $mainMenuId, subMenuId: $subMenuId, vloginName: $vloginName, vpassword: $vpassword, vfileUrl: $vfileUrl, cactionType: $cactionType}';
  }
}

