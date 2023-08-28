import 'dart:async';
import 'package:crm/views/crm_manager/reminder_creation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/reminder_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import '../home/home_page.dart';

class LeaveRequestListPage extends StatefulWidget {
  LeaveRequestListPage({Key? key, required this.title, required this.activityMode})
      : super(key: key);
  final String title;
  final int activityMode;
  @override
  _LeaveRequestListPageState createState() => _LeaveRequestListPageState();
}

class _LeaveRequestListPageState extends State<LeaveRequestListPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  ReminderCRUD reminderCRUD = ReminderCRUD();
  List<ReminderDetail>? ReminderList;
  IntSelectData enquirySelectData = new IntSelectData(0, "", "");
  int? count;
  bool _search = false;
  DateTime? test;
  late String header;
  @override
  void initState() {
    ReminderList = <ReminderDetail>[];
    updateListView(widget.activityMode, "");
    if (widget.activityMode == 1) {
      header = "Add Call";
    }
    if (widget.activityMode == 3) {
      header = "Add Meeting";
    }
    if (widget.activityMode == 6) {
      header = "Add Tasks";
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: _search
              ? Container(
            height: height * 0.05,
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(),
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
              ),
              onChanged: (text) {
                updateListView(widget.activityMode, text);
              },
            ),
          )
              : Text(widget.title),
          backgroundColor: Colors.purple,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(title: "CRM")))),
          actions: [
            _search
                ? IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _search = false;
                });
              },
            )
                : IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _search = true;
                });
              },
            )
          ],
          // automaticallyImplyLeading: false,
        ),
        body: (this.ReminderList!.length > 0)
            ? getLeaveRequestListPageView()
            : Center(
          child:this.count==null? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
          ):Text("No Records Found"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            debugPrint('FAB clicked');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RemindersEntryPage(
                      title: header,
                      iactivityMode: widget.activityMode,
                      enquirySelectData: new IntSelectData(0, "", ""),
                      fromEnq: false,
                      reminderList: [],
                    )));
          },
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  ListView getLeaveRequestListPageView() {
    // TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(this.ReminderList![position].vnextActivity!),
            subtitle: Text(
                "${ReminderList?[position].vnextActivityDate ?? ""} ${ReminderList?[position].vtime ?? ""}"),
            trailing: this.ReminderList![position].creminderStatus == "D"
                ? Icon(
              Icons.done_outline!,
              color: Colors.green,
            )
                : SizedBox(),
            onTap: () {
              int ireminder_id = 0;
              String vmode = "Default";
              if (ReminderList![position].vnextActivity != null &&
                  ReminderList![position].id != null) {
                ireminder_id = ReminderList![position].id!;
                vmode = ReminderList![position].vmode!;
              }
              // navigateToDetail(this.LeaveRequestListPage[position],'Edit Note');
            },
          ),
        );
      },
    );
  }

  void updateListView(int mode, String vname) async {
    /*--- Get Enquiry List Online-----*/
    await getReminderList(mode, 0, "", 0, vname, "").then((value) {
      setState(() {
        this.ReminderList = value!.remiderList!;
        this.count = ReminderList!.length;
      });
    });
/*--- Get Enquiry List Offline-----*/
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {
    //
    //   Future<List<ReminderDetail>> ReminderListFuture = reminderCRUD.getReminderList(mode,null);
    //   ReminderListFuture.then((ReminderListFuture) {
    //     setState(() {
    //       this.ReminderList = ReminderListFuture;
    //       this.count = ReminderListFuture.length;
    //     });
    //   });
    // });
  }
}
