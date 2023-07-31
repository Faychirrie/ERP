import 'dart:convert';
import 'dart:core';
import 'package:crm/models/property/property_master_model.dart';
import 'package:crm/views/crm_manager/reminder_list.dart';
import 'package:crm/views/property/property_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Home/menu_model.dart';
import '../../models/common/int_select_data.dart';
import '../../utils/firebase_api.dart';
import '../crm_manager/enquiry_generation.dart';
import '../crm_manager/enquiry_list.dart';
import '../crm_manager/reminder_creation.dart';
import '../user_management/user_login.dart';
import 'dashboard.dart';
import 'my_drawer_header.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;
  var pageTitle = "";
  bool openMenu = false;
  late SharedPreferences sharedPreferences;
  late MenuModel menuModel = new MenuModel(menuList: []);
  @override
  Future<SharedPreferences?> getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      menuModel = MenuModel.fromJson(
          jsonDecode(sharedPreferences.getString('menuData')!));
    });
    print("Drawer");
    print(sharedPreferences.get("url"));
    return sharedPreferences;
  }

  void initState() {
    getPrefs();
    super.initState();
  }

  Widget MyDrawerList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Scrollbar(
                child: ListView.builder(
              itemCount: menuModel.menuList.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text('${menuModel.menuList[index].vmenuName}'),
                  children: <Widget>[
                    ListView.builder(
                      itemCount:
                          menuModel.menuList[index].menuActionList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int innerIndex) {
                        return Container(
                            width:MediaQuery.of(context).size.width * 0.3,
                          child: Row(children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4),
                            InkWell(
                                child: Container(
                                  height: 30.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                      '${menuModel.menuList[index].menuActionList[innerIndex].vmoduleName}'),
                                ),
                                onTap: () async {
                                  setState(() {
                                    Navigator.pop(context);
                                    pageTitle = menuModel
                                        .menuList[index]
                                        .menuActionList[innerIndex]
                                        .vmoduleName!;
                                    if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "enquiryCreation") {
                                      print("-------------------------");
                                      currentPage =
                                          DrawerSections.enquiryCreation;
                                    } else if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "enquiryList") {
                                      currentPage = DrawerSections.enquiryList;
                                    } else if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "callsList") {
                                      currentPage = DrawerSections.callsList;
                                    } else if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "meetingList") {
                                      currentPage = DrawerSections.meetingList;
                                    }
                                    else if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "taskList") {
                                      currentPage = DrawerSections.taskList;
                                    }else if (menuModel.menuList[index]
                                            .menuActionList[innerIndex].vfileUrl
                                            ?.trim() ==
                                        "unitList") {
                                      currentPage = DrawerSections.unitList;
                                    }
                                    print("----------here---------------");
                                    print(currentPage);
                                  });
                                }),
                          ]),
                        );
                      },
                    ),
                  ],
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage(
        title: "Home",
      );
    } else if (currentPage == DrawerSections.enquiryCreation) {
      container = EnquiryGenerationPage(
        title: pageTitle,
        enquiryList: [],
        fromEnq: false,
      );
    } else if (currentPage == DrawerSections.enquiryList) {
      container = EnquiryListPage(
        title: 'Leads',
        select: false,
      );
    } else if (currentPage == DrawerSections.callsList) {
      container = ReminderListPage(
        title: 'Calls',
        activityMode: 1,
      );
    } else if (currentPage == DrawerSections.taskList) {
      container = ReminderListPage(
        title: 'Tasks',
        activityMode: 6,
      );
    }
    else if (currentPage == DrawerSections.meetingList) {
      container = ReminderListPage(
        title: 'Meetings',
        activityMode: 3,
      );
    }  else if (currentPage == DrawerSections.unitList) {
      container = PropertyListPage(title: 'Unit List', select: false, units: true,
      );
    }

    final height = MediaQuery.of(context).size.height;

    return
        // WillPopScope(
        // onWillPop: () async {
        //   MoveToBackground.moveTaskToBack();
        //   return false;
        // },
        // child:

        Scaffold(
      backgroundColor: Colors.white,
      body: container,
      drawer: Drawer(
        width:MediaQuery.of(context).size.width * 0.75,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                MyHeaderDrawer(
                  menuModel: menuModel,
                ),
                MyDrawerList(),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                    Text("Logout"),
                    IconButton(
                        onPressed: () async {
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.clear();
                          await Firebase.initializeApp();
                          await FirebaseApi().initNotifications("");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLogin(
                                    title: "User Login",
                                  )));
                        }, icon: Icon(Icons.arrow_forward))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  enquiryCreation,
  callsList,
  meetingList,
  enquiryList,
  taskList,
  unitList,
  privacy_policy,
  send_feedback,
}
