import 'package:sqflite/sqflite.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import 'database_helper.dart';

class NotesDetailCrud {
  static DatabaseHelper _databaseHelper = DatabaseHelper();// Singleton DatabaseHelper
  String noteDetailTable = 'Customer_Visit_Note_Detail';
  String id="id";
  String icustomer_visit_note_master_id="icustomer_visit_note_master_id";
  String imode="imode";
  String vremarks="vremarks";
  String vcommunicated_to="vcommunicated_to";
  String ddate="ddate";
  String vcreated_by="vcreated_by";
  String vupdated_by="vupdated_by";
  String dcreated_date="dcreated_date";
  String dupdated_date="dupdated_date";
  String cstatus="cstatus";

  // Fetch Operation: Get all NoteDetail objects from database
  Future<List<Map<String, dynamic>>> getNoteDetailMapList(
      int activity_mode, String? NoteDetailDate) async {
    Database db = await _databaseHelper.getDatabase();
    // NoteDetailDate=DateFormat('dd-MM-yyyy').format(DateFormat("dd-MM-yyyy").parse(NoteDetailDate!));
    var result;
    // var result2 = await db.rawQuery(
    //     'SELECT substr($dnext_activity_date, 1, 10) FROM $noteDetailTable');
    //
    // if (NoteDetailDate != null && activity_mode > 0) {
    //   result = await db.query(noteDetailTable,
    //       where: '$icustomer_visit_note_master_id= ? AND substr($dnext_activity_date, 1, 10)=?',
    //       whereArgs: [activity_mode, NoteDetailDate],
    //       orderBy: '$id ASC');
    // } else {
      result = await db.query(noteDetailTable,
          where: '$icustomer_visit_note_master_id= ?',
          whereArgs: [activity_mode],
          orderBy: '$id ASC');
    // }
//		var result = await db.rawQuery('SELECT * FROM $noteDetailTable order by $colPriority ASC');

    return result;
  }

  // Insert Operation: Insert a NoteDetail object to database
  Future<int> insertNoteDetail(
      NoteDetail noteDetail) async {
    Database db = await _databaseHelper.getDatabase();
    var result =
        await db.insert(noteDetailTable, noteDetail.toMap());
    return result;
  }

  // UpString Operation: UpString a NoteDetail object and save it to database
  Future<int> updateNoteDetail(NoteDetail noteDetail) async {
    var db = await _databaseHelper.getDatabase();
    var result = await db.update(noteDetailTable, noteDetail.toMap(),
        where: '$id= ?', whereArgs: [noteDetail.id]);
    return result;
  }

  // Delete Operation: Delete a NoteDetail object from database
  Future<int> deleteNoteDetail(int id) async {
    var db = await _databaseHelper.getDatabase();
    int result =
        await db.rawDelete('DELETE FROM $noteDetailTable WHERE $id = $id');
    return result;
  }

  // Get number of NoteDetail objects in database
  Future<int> getCount() async {
    Database db = await _databaseHelper.getDatabase();
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteDetailTable');
    int? result = Sqflite.firstIntValue(x);
    return result!;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'NoteDetail List' [ List<NoteDetail> ]
  Future<List<NoteDetail>> getNoteDetailList(
      int activity_mode, String? NoteDetailDate) async {
    var noteDetailMapList = await getNoteDetailMapList(
        activity_mode, NoteDetailDate); // Get 'Map List' from database
    int count =
        noteDetailMapList.length; // Count the number of map entries in db table

    List<NoteDetail> NoteDetailList =
        <NoteDetail>[];
    // For loop to create a 'NoteDetail List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      NoteDetailList
          .add(NoteDetail.fromMapObject(noteDetailMapList[i]));
    }

    return NoteDetailList;
  }
}
