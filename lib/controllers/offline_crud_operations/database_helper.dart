import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'reminder_crud.dart';
import 'url_crud.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database
  ReminderCRUD reminderCRUD= ReminderCRUD();
  URLCrud urlCrud= URLCrud();
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

 factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'Reminders.db';

    // Open/create the database at a given path
    var remindersDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return remindersDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE Enquiry_Generation_Master(id INTEGER PRIMARY KEY AUTOINCREMENT,vcustomer_name TEXT,vcustomer_address TEXT,vpermanent_city TEXT,vcustomer_mobile1 TEXT,'
            'vcustomer_mobile2 TEXT,vcustomer_email_address TEXT,vcustomer_email_address2 TEXT,vproperty_enquiry_code TEXT,vtemp_customer_code TEXT,denquiry_date TEXT,iproperty_id INTEGER,ipayment_terms_id INTEGER,mour_offer TEXT,'
            'ilead_source INTEGER,vremarks TEXT,vagent_code TEXT,vlead_by TEXT,fin_year TEXT,vcreated_by TEXT,dcreated_date TEXT,vupdated_by TEXT,dupdated_date TEXT,cstatus TEXT,cenquiry_status TEXT,clead_qualification TEXT,csync TEXT,icountry_id INTEGER,ibillboard_location_id INTEGER,ienquiry_detail_id INTEGER,city_id INTEGER)');
    await db.execute(
        'CREATE TABLE ${reminderCRUD.reminderTable}(${reminderCRUD.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${reminderCRUD.iactivity_mode} INTEGER, ${reminderCRUD.dnext_activity_date} TEXT, '
            '${reminderCRUD.vnext_activity} TEXT, ${reminderCRUD.ienquiry_id} INTEGER, ${reminderCRUD.vcreated_by} TEXT, ${reminderCRUD.vupdated_by} TEXT, ${reminderCRUD.dcreated_date} TEXT, ${reminderCRUD.dupdated_date} TEXT, ${reminderCRUD.creminder_status} TEXT, ${reminderCRUD.cstatus} TEXT)');
    await db.execute(
        'CREATE TABLE ${urlCrud.urltable}(${urlCrud.id} INTEGER PRIMARY KEY AUTOINCREMENT,  ${urlCrud.vurl} TEXT)');
 }
}
