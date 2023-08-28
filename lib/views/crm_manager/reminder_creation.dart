import 'package:crm/Utils/DateUtility/date_utils.dart';
import 'package:crm/views/crm_manager/reminder_list.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_state/phone_state.dart';

import '../../controllers/offline_crud_operations/reminder_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import '../../models/common/int_select_data.dart';
import 'enquiry_list.dart';

class RemindersEntryPage extends StatefulWidget {
  RemindersEntryPage(
      {Key? key,
      required this.title,
      required this.iactivityMode,
      required this.enquirySelectData,
      required this.fromEnq,
      required this.reminderList})
      : super(key: key);
  final String title;
  final int iactivityMode;
  final IntSelectData enquirySelectData;
  final bool fromEnq;
  final List<ReminderDetail> reminderList;
  @override
  _RemindersEntryPageState createState() => _RemindersEntryPageState();
}

class _RemindersEntryPageState extends State<RemindersEntryPage> {
  ReminderCRUD helper = ReminderCRUD();
  ReminderDetail reminder = ReminderDetail(
      null, 0, "", "", 0, "", "", "", "", "", "", "", "", "", "", "", "", "");
  String header = "";
  DateTime? selectedDate;
  late int ienquiry_id;
  late IntSelectData selectData;
  TextEditingController vnext_activityController = TextEditingController();
  TextEditingController leadController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _datecontroller = TextEditingController();

  @override
  void initState() {
    leadController.text = widget.enquirySelectData.vname;
    ienquiry_id = widget.enquirySelectData.id;
    if (widget.reminderList.length > 0) {
      vnext_activityController.text =
          widget.reminderList?[0].vnextActivity ?? "";
      _datecontroller.text = widget.reminderList?[0].vnextActivityDate ?? "";
      _timeController.text = widget.reminderList?[0].vtime ?? "";
      leadController.text = widget.reminderList?[0].vcustomerName ?? "";
      this.ienquiry_id = widget.reminderList?[0].ienquiryId ?? 0;
      reminder.id = widget.reminderList?[0].id ?? 0;
      reminder.vcreatedDate = widget.reminderList?[0].vcreatedDate ?? "";
      reminder.creminderStatus=widget.reminderList?[0].creminderStatus ?? "";
    }
    if (widget.iactivityMode == 1) {
      header = "Call List";
    }
    if (widget.iactivityMode == 3) {
      header = "Meeting List";
    }
    if (widget.iactivityMode == 6) {
      header = "Task List";
    }

    super.initState();
  }

  getEnquiryData(IntSelectData selectData) {
    setState(() {
      leadController.text = selectData.vname;
      ienquiry_id = selectData.id;
    });
  }

  void _save() async {
    print("Saving_________________1");
    reminder.dcreatedDate =
        DateFormat('dd-MM-yyyy hh:mm:ss a').format(DateTime.now());
    reminder.dnextActivityDate = _datecontroller.text;
    reminder.iactivityMode = widget.iactivityMode;
    reminder.vnextActivity = vnext_activityController.text;
    reminder.ienquiryId = ienquiry_id;
    reminder.vtime = _timeController.text;
    int result;
    String? response;
    print(reminder.id);
    if (reminder.id != null) {
      result = 0;
      response = await addReminders(reminder);
    } else {
      result = 0;
      reminder.creminderStatus = 'A';
      response = await addReminders(reminder);
    }

    if (result != 0 || response != null) {
      print('Reminder Saved Successfully');
      if (widget.fromEnq) {
        Navigator.of(context).pop(true);
      } else {
        moveToLastScreen();
      } // Success
    } else {
      print('Problem Saving Reminder');
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
                            controller: vnext_activityController,
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
                              labelText: 'Date',
                              labelStyle:
                                  new TextStyle(color: Colors.grey[600]),
                              prefixIcon: new IconButton(
                                icon: new Icon(Icons.event_note,
                                    color: Colors.purpleAccent),
                                onPressed: () async {
                                  // _showDatePicker(context);
                                  _datecontroller.text =
                                      (await getDatePicker(context))!;
                                },
                              ),
                              prefixText: ' ',
                            ),
                          ),
                          SizedBox(
                            height: height * 0.008,
                          ),
                          TextField(
                            controller: _timeController,
                            decoration: new InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.purple[100]!)),
                              labelText: 'Time',
                              labelStyle:
                                  new TextStyle(color: Colors.grey[600]),
                              prefixIcon: new IconButton(
                                icon: new Icon(Icons.access_time,
                                    color: Colors.purpleAccent),
                                onPressed: () async {
                                  _timeController.text =
                                      (await getTimePicker(context))!;
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
                              labelText: 'Customer Name',
                              labelStyle: TextStyle(color: Colors.grey[600]),
                              prefixText: ' ',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.purpleAccent,
                                ),
                                onPressed: () async {
                                  selectData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EnquiryListPage(
                                                title: 'Enquiry List',
                                                select: true,
                                              )));
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
                        ],
                      ),
                    )))
            // // color: Colors.white,
          ]),
          // ),
        ));
  }

  void moveToLastScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReminderListPage(
                  title: header,
                  activityMode: widget.iactivityMode,
                )));
  }
}
