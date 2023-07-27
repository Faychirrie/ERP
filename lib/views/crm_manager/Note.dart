import 'package:crm/views/crm_manager/reminder_creation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import 'notes_creation.dart';

class NotePage extends StatefulWidget {
  NotePage(
      {Key? key,
      required this.title,
      required this.id,
      required this.enquirySelectData,
      required this.ireminderId})
      : super(key: key);
  final String title;
  final int id;
  final int ireminderId;
  final IntSelectData enquirySelectData;
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  var name;
  int count = 0;
  List<NoteDetail>? notesDetailList;
  ReminderDetail reminder = ReminderDetail(
      null, 0, "", "", 0, "", "", "", "", "", "", "", "", "", "", "", "", "");
  bool isChecked = false;
  @override
  void initState() {
    updateNotesDetails(6);
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
      initialIndex: 0,
      length: 1,
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
                      bool reloadNotes = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteCreationPage(
                                    title: '',
                                    iactivityMode: notesDetailList![0].imode,
                                    enquirySelectData: widget.enquirySelectData,
                                    fromEnq: true,
                                    ireminderId: widget.ireminderId,
                                    notesDetailList: this.notesDetailList!, lcallLogId: widget.ireminderId,
                                  )));
                      if (reloadNotes) {
                        updateNotesDetails(6);
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
                // Tab(
                //   icon: Text("Details"),
                // ),
              ],
            ),
          ),
          body: Scrollbar(
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
                  child: this.notesDetailList!.length > 0
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            columnWidths: {2: FlexColumnWidth(0.2)},
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    "${notesDetailList?[0].vremarks ?? ""}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.blue),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Divider(),
                              ]),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff880e4f)),
                          ),
                        )),
            ),
          ))),
    );
  }

  void updateNotesDetails(int mode) async {
    await getNoteDetail(widget.id, 0, 0, 0, 0,0).then((value) {
      setState(() {
        this.notesDetailList = value!.noteDetail!;
      });
    });
  }
}
