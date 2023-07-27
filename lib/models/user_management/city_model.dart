import 'dart:convert';
CityModel cityModelFromJson(String str) =>
    CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) =>
    json.encode(data.toJson());

class CityModel
{
  String vstatusRemarks;
  dynamic vtransactionCode;
  dynamic vqueryResult;
  List<CityList> cityList;

  CityModel({
    required this.vstatusRemarks,
    this.vtransactionCode,
    this.vqueryResult,
    required this.cityList,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    vstatusRemarks: json["vstatus_remarks"],
    vtransactionCode: json["vtransaction_code"],
    vqueryResult: json["vquery_result"],
    cityList: List<CityList>.from(json["detailList"].map((x) => CityList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vstatus_remarks": vstatusRemarks,
    "vtransaction_code": vtransactionCode,
    "vquery_result": vqueryResult,
    "detailList": List<dynamic>.from(cityList.map((x) => x.toJson())),
  };
}

class CityList {
  int city_id;
  String cityName;
  CityList({
    required this.city_id,
    required this.cityName,
  });

  factory CityList.fromJson(Map<String, dynamic> json) =>
      CityList(
        city_id: json["city_id"],
        cityName: json["cityName"],
      );

  Map<String, dynamic> toJson() => {
    "city_id": city_id,
    "cityName": cityName,
  };
}