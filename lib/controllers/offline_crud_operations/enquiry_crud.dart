import 'package:sqflite/sqflite.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import 'database_helper.dart';

class EnquiryCRUD
{

  static DatabaseHelper _databaseHelper= DatabaseHelper(); // Singleton DatabaseHelper
  String enquiryTable = 'Enquiry_Generation_Master';
  String iactivity_mode = 'iactivity_mode';
  String id = 'id';
  String dnext_activity_date = 'dnext_activity_date';
  String vnext_activity = 'vnext_activity';
  String ienquiry_id = 'ienquiry_id';
  String vcreated_by = 'vcreated_by';
  String vupdated_by = 'vupdated_by';
  String dcreated_date = 'dcreated_date';
  String dupdated_date = 'dupdated_date';
  String creminder_status = 'creminder_status'; //Done(D) and Active(A)
  String cstatus = 'cstatus';
  // Fetch Operation: Get all Enquiry objects from database
  Future<List<Map<String, dynamic>>> getEnquiryMapList(
      int ienquiry_id, String? EnquiryDate) async {
    Database db =await _databaseHelper.getDatabase();

    var result;
    if(ienquiry_id>0)
      {
        result =await db.query(enquiryTable,where: '$id= ?', whereArgs: [ienquiry_id]);
      }else
        {
          result = await db.query("$enquiryTable",
              orderBy: 'id ASC');
        }



    return result;
  }

  // Insert Operation: Insert a Enquiry object to database
  Future<int> insertEnquiry(
      EnquiryList enquiry) async {
    Database db = await _databaseHelper.getDatabase();
    print("================Insert=======1");
    print(enquiryTable);
    var result =await db.insert(enquiryTable, enquiry.toMap());
    print(result);
    return result;
  }

  // UpString Operation: UpString a Enquiry object and save it to database
  Future<int> updateEnquiry(EnquiryList Enquiry) async {
    var db =await _databaseHelper.getDatabase();
    var result = await db.update("Enquiry_Generation_Master", Enquiry.toMap(),
        where: 'id= ?', whereArgs: [Enquiry.id]);
    return result;
  }

  // Delete Operation: Delete a Enquiry object from database
  Future<int> deleteEnquiry(int id) async {
    var db =await _databaseHelper.getDatabase();
    int result =
    await db.rawDelete('DELETE FROM Enquiry_Generation_Master WHERE id = $id');
    return result;
  }

  // Get number of Enquiry objects in database
  Future<int> getCount() async {
    Database db =await _databaseHelper.getDatabase();
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from Enquiry_Generation_Master');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Enquiry List' [ List<Enquiry> ]
  Future<List<EnquiryList>> getEnquiryList(
      int activity_mode, String? EnquiryDate) async {
    var EnquiryMapList = await getEnquiryMapList(
        activity_mode, EnquiryDate); // Get 'Map List' from database
    int count =
        EnquiryMapList.length; // Count the number of map entries in db table

    List<EnquiryList> enquiryList =
    <EnquiryList>[];
    // For loop to create a 'Enquiry List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      enquiryList
          .add(EnquiryList.fromMapObject(EnquiryMapList[i]));
    }

    return enquiryList;
  }

}