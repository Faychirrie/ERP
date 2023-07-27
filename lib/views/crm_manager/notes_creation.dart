
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/DateUtility/date_utils.dart';
import '../../controllers/offline_crud_operations/notes_detail_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/crm/customer_visit_note_detail_model.dart';
import '../../models/crm/customer_visit_note_master_model.dart';
import '../../models/common/int_select_data.dart';
import 'enquiry_list.dart';

class NoteCreationPage extends StatefulWidget {
  NoteCreationPage(
      {Key? key, required this.title, required this.iactivityMode, required this.enquirySelectData, required this.fromEnq, required this.ireminderId, required this.notesDetailList, required this.lcallLogId})
      : super(key: key);
  final String title;
  final int iactivityMode;
  final int ireminderId;
  final int lcallLogId;
  final IntSelectData enquirySelectData;
  final bool fromEnq;
  final   List<NoteDetail> notesDetailList;
  @override
  _NoteCreationPageState createState() => _NoteCreationPageState();
}

class _NoteCreationPageState extends State<NoteCreationPage> {
  NotesDetailCrud helper = NotesDetailCrud();
  late NoteDetail noteDetail= new NoteDetail(null, 0, 0, "", "", "", "", "", "", "", "", "", "", "", "", "", "",0,0,0);
  late NoteMaster noteMaster= new NoteMaster(null, "", 0, 0, "", "", "", "", "", "");
  String header = "";
  DateTime? selectedDate;
  late int ienquiry_id;
  late IntSelectData selectData;
  TextEditingController vremarksController = TextEditingController();
  TextEditingController dnext_activity_dateController = TextEditingController();
  TextEditingController leadController = TextEditingController();
  TextEditingController vcommunicatedToController = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();
  @override
  void initState() {
    leadController.text= widget.enquirySelectData.vname;
    ienquiry_id= widget.enquirySelectData.id;
    noteDetail.ireminderMasterId= widget.ireminderId;
    noteDetail.lcallLogId=widget.lcallLogId;
    if (widget.notesDetailList.length > 0)
    {
      print(widget.notesDetailList?[0].vcustomerName ?? "");
      vremarksController.text =widget.notesDetailList?[0].vremarks ?? "";
      _datecontroller.text =widget.notesDetailList?[0].vdate ?? "";
      vcommunicatedToController.text = widget.notesDetailList?[0].vcommunicatedTo ?? "";
      noteDetail.ireminderMasterId= widget.notesDetailList?[0].ireminderMasterId ?? 0;
      noteDetail.icustomerVisitNoteMasterId=widget.notesDetailList?[0].icustomerVisitNoteMasterId ?? 0;
      noteDetail.imode= widget.notesDetailList?[0].imode ?? 0;
      noteMaster.ienquiryId=widget.notesDetailList?[0].ienquiryId ?? 0;
      noteMaster.vtransactionCode=(widget.notesDetailList?[0].ienquiryId ?? 0).toString();
      noteDetail.id=widget.notesDetailList?[0].id ?? 0;
    }
    if (widget.iactivityMode == 1) {
      header="Call List";
    }
    if (widget.iactivityMode == 3) {
      header="Meeting List";
    }
    if (widget.iactivityMode == 6) {
      header="Task List";
    }
    super.initState();
  }
  // Update the description of Note object
  void updateDescription() {
    // reminder.dnext_activity_date = dnext_activity_dateController.text;
  }

  void _save() async {
    noteDetail.dcreatedDate =  DateFormat('dd-MM-yyyy hh:mm:ss a').format(DateTime.now());
    noteDetail.ddate=_datecontroller.text;
    noteDetail.vremarks=vremarksController.text;
    noteDetail.vcommunicatedTo=vcommunicatedToController.text;
    noteMaster.ienquiryId=ienquiry_id;
    noteMaster.vtransactionCode=ienquiry_id.toString();
    int result=0;
    int? response=0;
    if (noteDetail.id != null) {
      print("update===========");
      print(noteDetail.id);
      print(noteDetail.ireminderMasterId);
      // Case 1: Update operation
      await getNoteMasterList(0, ienquiry_id, "").then((value) async{
        if(value!>0)
        {
          print("update====1");
          noteDetail.icustomerVisitNoteMasterId= value!;
          response = await addNotesDetails(noteDetail);
        }else
        {
          print("update-------------2");
          await addNotesMaster(noteMaster).then((value) async{
            noteDetail.icustomerVisitNoteMasterId=value!;
            response = await addNotesDetails(noteDetail);
          }
          );
        }
      });
      // result = await helper.updateNoteDetail(noteDetail);
    } else {
      noteDetail.imode= widget.iactivityMode;
      // Case 2: Insert Operation
      // result = await helper.insertNoteDetail(noteDetail);
 await getNoteMasterList(0, ienquiry_id, "").then((value) async{
   if(value!>0)
   {
     print("save====1");
     noteDetail.icustomerVisitNoteMasterId= value!;
     response = await addNotesDetails(noteDetail);
   }else
   {
     print("Save-------------2");
   await addNotesMaster(noteMaster).then((value) async{
     noteDetail.icustomerVisitNoteMasterId=value!;
     response = await addNotesDetails(noteDetail);
   }
   );
   }
 });

    }

    if (result != 0|| response!>0) {
      print('Note Saved Successfully'); // Success
      moveToLastScreen();
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      print('Problem Saving Note');
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.purple,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => Navigator.pop(context)),
          actions: [
            Transform.scale(
              scale: 1.5,
              child: IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: () {
                  _save();
                },
                // onPressed: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => HomePage(title: "CRM")))
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: height * 0.021,
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: height * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextField(
                            controller: vremarksController,
                            onChanged: (value) {
                              debugPrint(
                                  'Something changed in Description Text Field');
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: (Colors.purple[100])!,
                                ),
                              ),
                              hintText: 'Enter Description',
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextField(
                            controller: _datecontroller,
                            decoration: new InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.purple[100]!)),
                              labelText: 'Note Date',
                              labelStyle:
                              new TextStyle(color: Colors.grey[600]),
                              prefixIcon: new IconButton(
                                icon: new Icon(Icons.event_note,
                                    color: Colors.purpleAccent),
                                onPressed: () async{
                                  _datecontroller.text = (await getDatePicker(context))!;
                                },
                              ),
                              prefixText: ' ',
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextField(
                            controller: leadController,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.purple[100]!)),
                              // helperText: 'Keep it short, this is just a demo.',
                              labelText: 'Lead Name',
                              labelStyle: TextStyle(color: Colors.grey[600]),
                              prefixText: ' ',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.purpleAccent,),
                                onPressed: () async {
                                  selectData= await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              EnquiryListPage( title: 'Enquiry List', select: true,)));
                                  if (selectData != null) {
                                    getEnquiryData(selectData);
                                  }
                                },
                              ),

                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextField(
                            controller: vcommunicatedToController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: (Colors.purple[100])!,
                                ),
                              ),
                              hintText: 'Communicated To',
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                        ],
                      ),
                    )))
            // // color: Colors.white,
          ]),
          // ),
        ));
  }

  void moveToLastScreen() {
    // Navigator.pop(context);
    Navigator.of(context).pop(true);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => ReminderListPage(
    //           title: header,
    //           activityMode: widget.iactivityMode,
    //         )));
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // showDialog(
    //     context: context,
    //     builder: (_) => alertDialog
    // );
  }
  getEnquiryData(IntSelectData selectData) {
    setState(() {
      leadController.text= selectData.vname;
      ienquiry_id= selectData.id;
    });
  }
}
