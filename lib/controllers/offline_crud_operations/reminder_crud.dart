import 'package:sqflite/sqflite.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import 'database_helper.dart';

class ReminderCRUD
{
  static DatabaseHelper _databaseHelper= DatabaseHelper(); // Singleton DatabaseHelper
  String reminderTable = 'Enquiry_Reminders_Master';
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

  // Fetch Operation: Get all Reminder objects from database
  Future<List<Map<String, dynamic>>> getReminderMapList(int activity_mode, String? reminderDate) async {
    Database db = await _databaseHelper.getDatabase();
    // reminderDate=DateFormat('dd-MM-yyyy').format(DateFormat("dd-MM-yyyy").parse(reminderDate!));
    var result;
    var result2 = await db.rawQuery('SELECT substr($dnext_activity_date, 1, 10) FROM $reminderTable');

    if(reminderDate!=null && activity_mode>0)
    {
      result=await db.query(reminderTable,where: '$iactivity_mode= ? AND substr($dnext_activity_date, 1, 10)=?', whereArgs: [activity_mode,reminderDate], orderBy: '$id ASC');

    }
    else{
      result=await db.query(reminderTable,where: '$iactivity_mode= ?', whereArgs: [activity_mode], orderBy: '$id ASC');

    }
//		var result = await db.rawQuery('SELECT * FROM $ReminderTable order by $colPriority ASC');

    return result;
  }

  // Insert Operation: Insert a Reminder object to database
  Future<int> insertReminder(
      ReminderDetail reminderDetail) async {
    print("Save Reminder===============2");
    Database db = await _databaseHelper.getDatabase();
    var result = await db.insert(reminderTable, reminderDetail.toMap());
    return result;
  }

  // UpString Operation: UpString a Reminder object and save it to database
  Future<int> updateReminder(ReminderDetail reminder) async {
    var db = await _databaseHelper.getDatabase();
    var result = await db.update(reminderTable, reminder.toMap(),
        where: '$id= ?', whereArgs: [reminder.id]);
    return result;
  }

  // Delete Operation: Delete a Reminder object from database
  Future<int> deleteReminder(int id) async {
    var db = await _databaseHelper.getDatabase();
    int result =
    await db.rawDelete('DELETE FROM $reminderTable WHERE $id = $id');
    return result;
  }

  // Get number of Reminder objects in database
  Future<int> getCount() async {
    Database db = await _databaseHelper.getDatabase();
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $reminderTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Reminder List' [ List<Reminder> ]
  Future<List<ReminderDetail>> getReminderList(int activity_mode,String? reminderDate) async {
    var reminderMapList =
    await getReminderMapList(activity_mode,reminderDate); // Get 'Map List' from database
    int count =
        reminderMapList.length; // Count the number of map entries in db table

    List<ReminderDetail> reminderList =
    <ReminderDetail>[];
    // For loop to create a 'Reminder List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      reminderList
          .add(ReminderDetail.fromMapObject(reminderMapList[i]));
    }

    return reminderList;
  }

}