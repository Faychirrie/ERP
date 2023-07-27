
import 'package:sqflite/sqflite.dart';
import '../../models/common/url_data_model.dart';
import 'database_helper.dart';
// var url='http://190.100.254.200:7227/epms01';
// var url='http://197.220.115.50:7227/epms01';
class URLCrud
{
  static DatabaseHelper _databaseHelper= DatabaseHelper(); // Singleton DatabaseHelper
  String urltable = 'url_master';
  String id = 'id';
  String vurl = 'vurl';

  // Fetch Operation: Get all Reminder objects from database
  Future<List<Map<String, dynamic>>> getUrl() async {
    Database db = await _databaseHelper.getDatabase();
    print("===================2");
		var result = await db.rawQuery('SELECT * FROM $urltable order by $id ASC');
    return result;
  }

  // Insert Operation: Insert a Reminder object to database
  Future<int> insertURl(
      URLDataModel urldata) async {
    print("Save Reminder===============2");
    Database db = await _databaseHelper.getDatabase();
    var result = await db.insert(urltable, urldata.toMap());
    return result;
  }

  // UpString Operation: UpString a Reminder object and save it to database
  Future<int> updateURL(URLDataModel urlDataModel) async {
    var db = await _databaseHelper.getDatabase();
    var result = await db.update(urltable, urlDataModel.toMap(),
        where: '$id= ?', whereArgs: [urlDataModel.id]);
    return result;
  }

  // Delete Operation: Delete a Reminder object from database
  Future<int> deleteURL(int id) async {
    var db = await _databaseHelper.getDatabase();
    int result =
    await db.rawDelete('DELETE FROM $urltable WHERE $id = $id');
    return result;
  }

  // Get number of Reminder objects in database
  Future<int> getCount() async {
    Database db = await _databaseHelper.getDatabase();
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $urltable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Reminder List' [ List<Reminder> ]
  Future<List<URLDataModel>> getUrlList() async {
    print("===================1");
    var urlMapList =
    await getUrl(); // Get 'Map List' from database
    int count =
        urlMapList.length; // Count the number of map entries in db table

    List<URLDataModel>urlList =
    <URLDataModel>[];
    // For loop to create a 'Reminder List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      urlList
          .add(URLDataModel.fromMapObject(urlMapList[i]));
    }

    return urlList;
  }

}