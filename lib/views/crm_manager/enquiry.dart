
import 'package:crm/views/crm_manager/app_call.dart';
import 'package:crm/views/crm_manager/reminder_creation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/crm/call_Log_data_model.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import '../../models/common/int_select_data.dart';
import 'Note.dart';
import 'Reminder.dart';
import 'enquiry_generation.dart';
import 'notes_creation.dart';

class EnquiryPage extends StatefulWidget {
  EnquiryPage({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final int id;
  @override
  _EnquiryPageState createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<EnquiryPage> {
  List<EnquiryList>? enquiryList;
  DatabaseHelper databaseHelper = DatabaseHelper();
  EnquiryCRUD enquiryCRUD = EnquiryCRUD();
  IntSelectData enquirySelectData = new IntSelectData(0, "", "");
  var name;
  int count = 0;
  List<ReminderDetail>? reminderList;
  List<ReminderDetail>? callReminderList;
  List<CallLogList>? callLogList;
  List<ReminderDetail>? meetingReminderList;
  List<ReminderDetail>? taskReminderList;
  List<NoteDetail>? notesDetailList;
  String title = "";
  @override
  void initState() {
    updateCallLog();
    updateNoteDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (enquiryList == null) {
      getEnquiryDetails(widget.id);
    }
    if (reminderList == null) {
      reminderList = <ReminderDetail>[];
      updateReminderDetails(1);
    }
    if (callReminderList == null) {
      callReminderList = <ReminderDetail>[];
      updateReminderDetails(1);
    }
    if (meetingReminderList == null) {
      meetingReminderList = <ReminderDetail>[];
      updateReminderDetails(3);
    }
    if (taskReminderList == null) {
      taskReminderList = <ReminderDetail>[];
      updateReminderDetails(6);
    }
    if (notesDetailList == null) {
      notesDetailList = <NoteDetail>[];
      updateNoteDetails();
    }
    if (callLogList == null) {
      callLogList = <CallLogList>[];
      updateCallLog();
    }
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.purple,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => Navigator.of(context).pop(true)),
          actions: [
            Transform.scale(
              scale: 1.5,
              child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () async{
                    bool reloadEnquiry = false;
                    reloadEnquiry = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnquiryGenerationPage(
                              title: "Edit ${widget.title}",
                              enquiryList: this.enquiryList!,
                              fromEnq: true,
                            )));
                    if (reloadEnquiry) {
                      getEnquiryDetails(widget.id);
                    }

                    // _save();
                  }),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Text("Basic"),
              ),
              Tab(
                icon: Text("Details"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
                child: SafeArea(
              child: Column(children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //Calendar

                        //Calls
                        Container(
                          height: height * 0.045,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Notes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Align(
                                alignment: FractionalOffset.centerRight,
                                child: IconButton(
                                  icon: new Icon(Icons.add),
                                  color: Colors.purple,
                                  onPressed: () async {
                                    bool reloadNotes = false;
                                    reloadNotes = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => NoteCreationPage(
                                                  title: "Add Notes",
                                                  iactivityMode: 1,
                                                  enquirySelectData:
                                                      enquirySelectData,
                                                  fromEnq: true,
                                                  ireminderId: 0, notesDetailList: [], lcallLogId: 0,
                                                )));
                                    if (reloadNotes) {
                                      updateNoteDetails();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Scrollbar(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: notesDetailList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Material(
                                            elevation: 0,
                                            shadowColor: Colors.purple,
                                            child: ListTile(
                                              title: Text(
                                                  ' ${notesDetailList![index].vremarks}'),
                                              subtitle: Text(
                                                  ' ${notesDetailList![index].vmode}'),
                                                onTap: () async{
                                                  int inoteId = notesDetailList![index].id!;
                                                  String vtitle = "Notes";
                                                  bool reloadNotes;
                                                  reloadNotes= await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NotePage(
                                                                title: vtitle,
                                                                id: inoteId,
                                                                enquirySelectData:enquirySelectData,
                                                                ireminderId: 0,
                                                              )));
                                                  if(reloadNotes)
                                                    {
                                                      updateNoteDetails();
                                                    }
                                                  // navigateToDetail(this.ReminderListPage[position],'Edit Note');
                                                }// Icons.more_vert
                                            ),

                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))),
                        //Tasks
                        Container(
                          height: height * 0.045,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tasks",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Align(
                                alignment: FractionalOffset.centerRight,
                                child: IconButton(
                                  icon: new Icon(Icons.add),
                                  color: Colors.purple,
                                  onPressed: () async {
                                    bool reloadTasks = false;
                                    reloadTasks = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RemindersEntryPage(
                                                    title: 'Add Task',
                                                    iactivityMode: 6,
                                                    enquirySelectData:
                                                        enquirySelectData,
                                                    fromEnq: true, reminderList: [],)));

                                    if (reloadTasks) {
                                      updateReminderDetails(6);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //     child:
                        Container(
                          height: height * 0.25,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Scrollbar(
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: taskReminderList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Material(
                                          elevation: 0,
                                          shadowColor: Colors.purple,
                                          child: GestureDetector(
                                            onTap: () async{
                                              bool reloadReminder;
                                              int ireminderId = 0;
                                              String vmode = "Default";
                                              if (taskReminderList![index]
                                                          .vnextActivity !=
                                                      null &&
                                                  taskReminderList![index].id !=
                                                      null) {
                                                ireminderId =
                                                    taskReminderList![index]
                                                        .id!;
                                                vmode = taskReminderList![index]
                                                    .vmode!;
                                                print("reminder id========");
                                                print(ireminderId);
                                              }
                                              reloadReminder= await  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReminderPage(
                                                            title: vmode,
                                                            id: ireminderId,
                                                            enquirySelectData:
                                                                enquirySelectData,
                                                          )));
                                              if(reloadReminder)
                                                {
                                                  updateReminderDetails(1);
                                                  updateReminderDetails(3);
                                                  updateReminderDetails(6);
                                                }
                                            },
                                            child: ListTile(
                                              title: Text(
                                                  ' ${taskReminderList![index].vnextActivity}'),
                                              subtitle: Text(
                                                  ' ${taskReminderList![index].vnextActivityDate} ${taskReminderList![index].vtime}'), // Icons.more_vert
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    );
                                  })),
                        ),
                        // ),
                        SizedBox(
                          height: height * 0.001,
                        ),

                        //meetings
                        Container(
                          height: height * 0.045,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Meetings",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Align(
                                alignment: FractionalOffset.centerRight,
                                child: IconButton(
                                  icon: new Icon(Icons.add),
                                  color: Colors.purple,
                                  onPressed: () async {
                                    bool reloadTasks = false;
                                    reloadTasks = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RemindersEntryPage(
                                                    title: 'Add Meeting',
                                                    iactivityMode: 3,
                                                    enquirySelectData:
                                                    enquirySelectData,
                                                    fromEnq: true, reminderList: [],)));

                                    if (reloadTasks) {
                                      updateReminderDetails(3);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Scrollbar(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: meetingReminderList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Material(
                                            elevation: 0,
                                            shadowColor: Colors.purple,
                                            child: GestureDetector(
                                              onTap: () {
                                                int ireminderId = 0;
                                                String vmode = "Default";
                                                if (meetingReminderList![index]
                                                            .vnextActivity !=
                                                        null &&
                                                    meetingReminderList![index]
                                                            .id !=
                                                        null) {
                                                  ireminderId =
                                                      meetingReminderList![
                                                              index]
                                                          .id!;
                                                  vmode = meetingReminderList![
                                                          index]
                                                      .vmode!;
                                                  print("reminder id========");
                                                  print(ireminderId);
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReminderPage(
                                                              title: vmode,
                                                              id: ireminderId,
                                                              enquirySelectData:
                                                                  enquirySelectData,
                                                            )));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    ' ${meetingReminderList![index].vnextActivity}'),
                                                subtitle: Text(
                                                    ' ${meetingReminderList![index].vnextActivityDate} ${meetingReminderList![index].vtime}'), // Icons.more_vert
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))),

                        //Manual Calls
                        Container(
                          height: height * 0.045,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Manual Calls",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              Align(
                                alignment: FractionalOffset.centerRight,
                                child: IconButton(
                                  icon: new Icon(Icons.add),
                                  color: Colors.purple,
                                  onPressed: () async {
                                    bool reloadTasks = false;
                                    reloadTasks = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RemindersEntryPage(
                                                    title: 'Add Calls',
                                                    iactivityMode: 1,
                                                    enquirySelectData:
                                                    enquirySelectData,
                                                    fromEnq: true, reminderList: [],)));

                                    if (reloadTasks) {
                                      updateReminderDetails(1);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Scrollbar(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: callReminderList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Material(
                                            elevation: 0,
                                            shadowColor: Colors.purple,
                                            child: GestureDetector(
                                              onTap: () {
                                                int ireminderId = 0;
                                                String vmode = "Default";
                                                if (callReminderList![index]
                                                            .vnextActivity !=
                                                        null &&
                                                    callReminderList![index]
                                                            .id !=
                                                        null) {
                                                  ireminderId =
                                                      callReminderList![index]
                                                          .id!;
                                                  vmode =
                                                      callReminderList![index]
                                                          .vmode!;
                                                  print("reminder id========");
                                                  print(ireminderId);
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReminderPage(
                                                              title: vmode,
                                                              id: ireminderId,
                                                              enquirySelectData:
                                                                  enquirySelectData,
                                                            )));
                                              },
                                              child: ListTile(
                                                title: Text(
                                                    ' ${callReminderList![index].vnextActivity}'),
                                                subtitle: Text(
                                                    ' ${callReminderList![index].vnextActivityDate} ${callReminderList![index].vtime}'), // Icons.more_vert
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))),
                        //App Calls
                        Container(
                          height: height * 0.045,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "App Calls",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Scrollbar(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: callLogList!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Material(
                                            elevation: 0,
                                            shadowColor: Colors.purple,
                                            child: GestureDetector(
                                              onTap: () async{
                                               int icall_log_id=callLogList![index].id!;
                                                bool reloadCallLogs;
                                                reloadCallLogs= await  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AppCallPage(
                                                              title: "Call Log",
                                                              id: icall_log_id,
                                                              enquirySelectData:
                                                              enquirySelectData,
                                                            )));
                                              },
                                              child: ListTile(
                                                leading: Icon(Icons.outbond,),
                                                title: Text(
                                                    ' ${callLogList![index].vcustomerName}'),
                                                subtitle: Text(
                                                    ' ${callLogList![index].vfromTime} duration: ${callLogList![index].vduration}'), // Icons.more_vert
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))),
                      ],
                    ),
                  ),
                ),

                // // color: Colors.white,
              ]),
            )),
            Scrollbar(
                // alignment: Alignment.topCenter,
                child: Container(
              height: height * 0.5,
              padding: EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 20,
                color: Colors.grey[300],
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        columnWidths: {2: FlexColumnWidth(0.2)},
                        children: [
                          TableRow(
                            children: [
                              Text(
                                "Name:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerName ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Phone Number:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerMobile1 ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerEmailAddress ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Address:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerAddress ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Qualification:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vstatusName ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Source:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].venquirySource ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Agent:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vagentName ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Billboard Location:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vbillboard_location ?? 0}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Our Offer:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].mourOffer ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Payment Terms:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vpayment_term_name ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Date:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].venquiryDate ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Remarks:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vremarks ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "City:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].cityName ?? 0}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Address:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerAddress ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Alternative Mobile:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerMobile2 ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                          TableRow(children: [
                            Divider(),
                            Divider(),
                          ]),
                          TableRow(
                            children: [
                              Text(
                                "Alternative Email:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "${enquiryList?[0].vcustomerEmailAddress2 ?? ""}",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void getEnquiryDetails(int id) async {
    await getEnquiryList(id, "","").then((value) {
      setState(() {
        this.enquiryList = value!.enquiryList!;
        this.title= enquiryList?[0].vcustomerName ?? "";
        enquirySelectData = new IntSelectData(
            enquiryList?[0].id ?? 0, enquiryList?[0].vcustomerName ?? "", "");
      });
    });
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<EnquiryList>> enquiryListFuture =
    //       enquiryCRUD.getEnquiryList(id, null);
    //   enquiryListFuture.then((enquiryListFuture) {
    //     setState(() {
    //       this.enquiryList = enquiryListFuture;
    //     });
    //   });
    // });
  }

  void updateReminderDetails(int mode) async {
    await getReminderList(mode, widget.id, "", 0, "","").then((value) {
      setState(() {
        if (mode == 1) {
          this.callReminderList = value!.remiderList!;
        }
        if (mode == 3) {
          this.meetingReminderList = value!.remiderList!;
        }
        if (mode == 6) {
          this.taskReminderList = value!.remiderList!;
        }
        this.reminderList = value!.remiderList!;
        this.count = value!.remiderList!.length;
      });
    });

    // DatabaseHelper databaseHelper = DatabaseHelper();
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<ReminderDetail>> ReminderListFuture =
    //       reminderCRUD.getReminderList(
    //           mode, DateFormat('dd-MM-yyyy').format(_selectedDate.value!));
    //   ReminderListFuture.then((ReminderListFuture) {
    //     setState(() {
    //       if (mode == 1) {
    //         this.callReminderList = ReminderListFuture;
    //       }
    //       if (mode == 3) {
    //         this.meetingReminderList = ReminderListFuture;
    //       }
    //       if (mode == 6) {
    //         this.taskReminderList = ReminderListFuture;
    //       }
    //       this.ReminderList = ReminderListFuture;
    //       this.count = ReminderListFuture.length;
    //     });
    //   });
    // });
  }

  void updateNoteDetails() async {
    await getNoteDetail(0, 0, 0, widget.id, 0,0).then((value) {
      setState(() {
        this.notesDetailList = value!.noteDetail!;
      });
    });
  }
  void updateCallLog() async {
    await getCallLogList(widget.id,0).then((value) {
      setState(() {
        this.callLogList = value!.callLogList!;
      });
    });
  }
}
