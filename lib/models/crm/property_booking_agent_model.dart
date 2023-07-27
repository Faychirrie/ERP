import 'dart:convert';
PropertyBookingAgentModel propertyBookingAgentModelFromJson(String str) =>
    PropertyBookingAgentModel.fromJson(json.decode(str));

String propertyBookingAgentModelToJson(PropertyBookingAgentModel data) =>
    json.encode(data.toJson());
class PropertyBookingAgentModel
{
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<AgentList> agentList;

  PropertyBookingAgentModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.agentList,
  });

  factory PropertyBookingAgentModel.fromJson(Map<String, dynamic> json) => PropertyBookingAgentModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    agentList: List<AgentList>.from(json["detailList"].map((x) => AgentList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(agentList.map((x) => x.toJson())),
  };
}
class AgentList {
  int id;
  String vagent_code;
  String vagent_name;
  AgentList({
    required this.id,
    required this.vagent_code,
    required this.vagent_name,
  });

  factory AgentList.fromJson(Map<String, dynamic> json) =>
      AgentList(
        id: json["id"],
        vagent_code: json["vagent_code"],
        vagent_name: json["vagent_name"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vagent_code": vagent_code,
    "vagent_name": vagent_name,
  };
}
