
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_state/phone_state.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/offline_crud_operations/reminder_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/crm/enquiry_reminders_master_model.dart';
import '../../models/common/int_select_data.dart';
import '../crm_manager/Reminder.dart';
import '../crm_manager/reminder_creation.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  late ValueNotifier<DateTime> _selectedDate;
  late DateTime _firstDay;
  late DateTime _lastDay;
  String route='';
  bool _search = false;
  IntSelectData enquirySelectData = new IntSelectData(0, "","");

  @override
  void initState() {
    super.initState();
    _selectedDate = ValueNotifier(DateTime.now());
    print('_selectedDate============================================');
    print(_selectedDate!);
    _calculateWeekRange(_selectedDate.value);
  }

  void _calculateWeekRange(DateTime selectedDate) {
    _firstDay = selectedDate.subtract(Duration(days: selectedDate.weekday));
    print('selectedDate.weekday============================================');
    print(_firstDay);
    _lastDay = selectedDate.add(Duration(days: 7 - selectedDate.weekday));
    print(_lastDay);
  }

  List<ReminderDetail>? ReminderList;
  List<ReminderDetail>? callReminderList;
  List<ReminderDetail>? meetingReminderList;
  List<ReminderDetail>? taskReminderList;
  ReminderCRUD reminderCRUD = ReminderCRUD();
  late PageController _pageController;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (ReminderList == null) {
      ReminderList = <ReminderDetail>[];
      updateListView(1,"");
    }
    if (callReminderList == null) {
      callReminderList = <ReminderDetail>[];
      updateListView(1,"");
    }
    if (meetingReminderList == null) {
      meetingReminderList = <ReminderDetail>[];
      updateListView(3,"");
    }
    if (taskReminderList == null) {
      taskReminderList = <ReminderDetail>[];
      updateListView(6,"");
    }
    final height = MediaQuery.of(context).size.height;
    return new WillPopScope(
      onWillPop: () async {
       // await MinimizeApp.minimizeApp();
      // Minimize the app when the back button is pressed
      return false;
    },
      child: Scaffold(
          backgroundColor: Colors.white,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Search',
                      ),
                      onChanged: (text) {
                        updateListView(1, text);
                        updateListView(3, text);
                        updateListView(6, text);
                      },
                    ),
                  )
                : Text(widget.title),
            backgroundColor: Colors.purple,
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () => Scaffold.of(context).openDrawer()),
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
          body: SafeArea(
            child: Column(children: [
              //Calendar
              ValueListenableBuilder<DateTime>(
                valueListenable: _selectedDate,
                builder: (context, value, _) {
                  return TableCalendar(
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.purple[200],
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _selectedDate.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, _selectedDate.value),
                    calendarFormat: CalendarFormat.week,
                    onDaySelected: (date, _) {
                      setState(() {
                        _selectedDate = ValueNotifier(date);
                        _calculateWeekRange(_selectedDate.value);
                        updateListView(6,"");
                        updateListView(1,"");
                        updateListView(3,"");
                      });
                    },
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _selectedDate.value = focusedDay;
                        // _calculateWeekRange(_selectedDate.value);
                      });
                    },
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RemindersEntryPage(
                                                  title: "Add Tasks",
                                                  iactivityMode: 6,
                                                  enquirySelectData:
                                                      enquirySelectData,
                                                  fromEnq: false, reminderList: [],)));
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
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Material(
                                      elevation: 0,
                                      shadowColor: Colors.purple,
                                      child:GestureDetector(
                                        onTap: () async{
                                          int ireminder_id = 0;
                                          String vmode = "Default";
                                          if (taskReminderList![index]
                                              .vnextActivity !=
                                              null &&
                                              taskReminderList![index].id !=
                                                  null) {
                                            ireminder_id =
                                            taskReminderList![index].id!;
                                            vmode =
                                            taskReminderList![index]
                                                .vmode!;
                                          }
                                          bool reloadReminder;
                                          print("reloadReminder");
                                          reloadReminder= await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReminderPage(
                                                          title:
                                                          vmode,
                                                          id: ireminder_id, enquirySelectData: enquirySelectData,)));
                                          print(reloadReminder);
                                          if(reloadReminder)
                                          {
                                            updateListView(6,"");
                                          }
                                        },
                                        child:  ListTile(
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
                              }),
                        ),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RemindersEntryPage(
                                                  title: "Add Meeting",
                                                  iactivityMode: 3,
                                                  enquirySelectData:
                                                      enquirySelectData,
                                                  fromEnq: false, reminderList: [],)));
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
                                          child:GestureDetector(
                                            onTap: () async{
                                              int ireminder_id = 0;
                                              String vmode = "Default";
                                              if (meetingReminderList![index]
                                                  .vnextActivity !=
                                                  null &&
                                                  meetingReminderList![index].id !=
                                                      null) {
                                                ireminder_id =
                                                meetingReminderList![index].id!;
                                                vmode =
                                                meetingReminderList![index]
                                                    .vmode!;
                                              }
                                              bool reloadReminder;
                                              print("reloadReminder");
                                              reloadReminder= await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReminderPage(
                                                              title:
                                                              vmode,
                                                              id: ireminder_id, enquirySelectData: enquirySelectData,)));
                                              if(reloadReminder)
                                              {
                                                updateListView(3,"");
                                              }
                                            },
                                            child:  ListTile(
                                              title: Text(
                                                  ' ${meetingReminderList![index].vnextActivity}'),
                                              subtitle: Text(
                                                  ' ${meetingReminderList![index].vnextActivityDate}  ${meetingReminderList![index].vtime}'), // Icons.more_vert
                                            ),
                                          ),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    );
                                  }))),

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
                              "Calls",
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RemindersEntryPage(
                                                  title: "Add Calls",
                                                  iactivityMode: 1,
                                                  enquirySelectData:
                                                      enquirySelectData,
                                                  fromEnq: false, reminderList: [],)));
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
                                      child:GestureDetector(
                                        onTap: () async{
                                          int ireminder_id = 0;
                                          String vmode = "Default";
                                          if (callReminderList![index]
                                              .vnextActivity !=
                                              null &&
                                              callReminderList![index].id !=
                                                  null) {
                                            ireminder_id =
                                            callReminderList![index].id!;
                                            vmode =
                                            callReminderList![index]
                                                .vmode!;
                                          }
                                          bool reloadReminder;
                                          print("reloadReminder");
                                          reloadReminder= await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReminderPage(
                                                          title:
                                                          vmode,
                                                          id: ireminder_id, enquirySelectData: enquirySelectData,)));
                                          if(reloadReminder)
                                          {
                                            updateListView(1,"");
                                          }
                                        },
                                        child:  ListTile(
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
                    ],
                  ),
                ),
              ),

              // // color: Colors.white,
            ]),
            // ),
          )),
    );
  }

  void updateListView(int mode,String vname) async {
    await getReminderList(
            mode, 0, DateFormat('dd/MM/yyyy').format(_selectedDate.value!),0,vname,"A")
        .then((value) {
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
        this.ReminderList = value!.remiderList!;
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
}
