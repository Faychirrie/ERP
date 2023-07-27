import 'package:crm/models/crm/call_Log_data_model.dart';
import 'package:crm/views/crm_manager/Note.dart';
import 'package:flutter/material.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import 'notes_creation.dart';

class AppCallPage extends StatefulWidget {
  AppCallPage(
      {Key? key,
        required this.title,
        required this.id,
        required this.enquirySelectData})
      : super(key: key);
  final String title;
  final int id;
  final IntSelectData enquirySelectData;
  @override
  _AppCallPageState createState() => _AppCallPageState();
}

class _AppCallPageState extends State<AppCallPage> {
  var name;
  int count = 0;
  int iactivity_mode=7;
  List<CallLogList> callLogList=<CallLogList>[];
  List<NoteDetail>? notesDetailList;
  bool isChecked = false;
  @override
  void initState() {
    // callLogList = <ReminderDetail>[];
    print('step 2===========');
    getCallLogDetails(widget.id);
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
                                                      ireminderId: 0, notesDetailList: [], lcallLogId: widget.id,
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
                                                      // navigateToDetail(this.callLogListPage[position],'Edit Note');
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
                        child: this.callLogList!.length > 0
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
                                    "${callLogList?[0].vcustomerName ?? ""}",
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
                                    "${callLogList?[0].vfromTime ?? ""}",
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
                                    "${callLogList?[0].vtime ?? ""}",
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
                                    "${callLogList?[0].vduration ?? ""}",
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

  void getCallLogDetails(int id) async {
    print('step 3===========');
    print(id);
    await getCallLogList(0,widget.id).then((value) {
      print('step 5===========');
      setState(() {
        this.callLogList = value!.callLogList!;
      });
      print(this.iactivity_mode);
    });
  }

  void updateNotesDetails(int mode) async {
    await getNoteDetail(0, 0, 0, 0,0, widget.id).then((value) {
      setState(() {
        this.notesDetailList = value!.noteDetail!;
      });
    });
  }
}
