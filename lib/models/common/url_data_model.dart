class URLDataModel {
  int? _id;
  late String _vurl;


  URLDataModel(this._id, this._vurl);

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  URLDataModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._vurl = map['vurl'];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['vurl'] = _vurl;
    return map;
  }

  String get vurl => _vurl;

  set vurl(String value) {
    _vurl = value;
  }
}