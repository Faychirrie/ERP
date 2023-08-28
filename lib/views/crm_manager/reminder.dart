import 'package:crm/views/crm_manager/Note.dart';
import 'package:crm/views/crm_manager/reminder_creation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import 'notes_creation.dart';

class ReminderPage extends StatefulWidget {
  ReminderPage(
      {Key? key,
      required this.title,
      required this.id,
      required this.enquirySelectData})
      : super(key: key);
  final String title;
  final int id;
  final IntSelectData enquirySelectData;
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  var name;
  int count = 0;
  int iactivity_mode=0;
  List<ReminderDetail> reminderList=<ReminderDetail>[];
  List<NoteDetail>? notesDetailList;
  ReminderDetail reminder = ReminderDetail(
      null, 0, "", "", 0, "", "", "", "", "", "", "", "", "", "", "", "", "");
  bool isChecked = false;
  @override
  void initState() {
    // reminderList = <ReminderDetail>[];
    print('step 2===========');
    getReminderDetails(widget.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (notesDetailList == null) {
      notesDetailList = <NoteDetail>[];
      updateNotesDetails(6);
    }
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                  onPressed: () async {
                    bool reloadReminder = false;
                    reloadReminder = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RemindersEntryPage(
                                  title: 'Edit ${widget.title}',
                                  iactivityMode: this.iactivity_mode,
                                  enquirySelectData:
                                      new IntSelectData(0, '', ""),
                                  fromEnq: true,
                                  reminderList: this.reminderList!,
                                )));
                    if (reloadReminder) {
                      getReminderDetails(widget.id);
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
                ListTile(
                  leading: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                          if (isChecked) {
                            reminder.creminderStatus = 'D';
                            var myFormat = DateFormat('d/MM/yyyy');
                            String vreminderDate= myFormat.format(DateFormat("d/MM/yyyy").parse(reminder?.dnextActivityDate??""));
                            reminder.dnextActivityDate=vreminderDate;
                            addReminders(reminder);
                          }
                        });
                      }),
                  title: Text("${reminder.vnextActivity}"),
                  subtitle: reminder.creminderStatus == "D"
                      ? Text("Complete")
                      : Text("Pending"),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
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
                                            builder: (context) =>
                                                NoteCreationPage(
                                                  title: "Add Notes",
                                                  iactivityMode: 1,
                                                  enquirySelectData:
                                                      widget.enquirySelectData,
                                                  fromEnq: true,
                                                  ireminderId: widget.id, notesDetailList: [], lcallLogId: 0,
                                                )));
                                    if (reloadNotes) {
                                      updateNotesDetails(0);
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
                                                  int inote_id = notesDetailList![index].id!;
                                                  String vtitle = "Notes";
                                                  bool reloadNotes;
                                                  reloadNotes=  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NotePage(
                                                                title: vtitle,
                                                                id: inote_id,
                                                                enquirySelectData:widget.enquirySelectData, ireminderId: widget.id,
                                                              )));
                                                  if(reloadNotes)
                                                  {
                                                    updateNotesDetails(iactivity_mode);
                                                  }
                                                  // navigateToDetail(this.ReminderListPage[position],'Edit Note');
                                                } // Icons.more_vert
                                                ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))),

                        // ),
                        SizedBox(
                          height: height * 0.001,
                        ),
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
                    child: this.reminderList!.length > 0
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Table(
                              columnWidths: {2: FlexColumnWidth(0.2)},
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      "Activity:",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "${reminderList?[0].vnextActivity ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
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
                                      "${reminderList?[0].vnextActivityDate ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
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
                                      "Time:",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "${reminderList?[0].vtime ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
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
                                      "Mode:",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "${reminderList?[0].vmode ?? ""}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                    ),
                                  ],
                                ),
                                TableRow(children: [
                                  Divider(),
                                  Divider(),
                                ]),
                              ],
                            ),
                          )
                        :Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff880e4f)),
                    ),) ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void getReminderDetails(int id) async {
    print('step 3===========');
    print(id);
    await getReminderList(0, 0, "", id, "", "").then((value) {
      print('step 5===========');
      setState(() {
        this.reminderList = value!.remiderList!;
        if (reminderList != null && reminderList!.length > 0) {
          this.reminder = reminderList![0];
          this.reminder.dnextActivityDate= this.reminder.vnextActivityDate!;
          this.iactivity_mode= reminderList![0].iactivityMode;
          if (reminderList![0].creminderStatus == "D") {
            isChecked = true;
          }
        }
      });
      print(this.iactivity_mode);
    });
  }

  void updateNotesDetails(int mode) async {
    await getNoteDetail(0, 0, 0, 0, widget.id,0).then((value) {
      setState(() {
        this.notesDetailList = value!.noteDetail!;
      });
    });
  }
}
