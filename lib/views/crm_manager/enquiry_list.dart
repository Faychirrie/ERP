import 'package:crm/views/crm_manager/reminder_creation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/Home/menu_details.dart';
import '../../models/Home/menu_items.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import '../../models/crm/lead_qualification_master_model.dart';
import '../home/home_page.dart';
import 'enquiry.dart';
import 'enquiry_generation.dart';

class EnquiryListPage extends StatefulWidget {
  EnquiryListPage({Key? key, required this.title, required this.select})
      : super(key: key);
  final String title;
  final bool select;
  @override
  _EnquiryListPageState createState() => _EnquiryListPageState();
}

class _EnquiryListPageState extends State<EnquiryListPage> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  DatabaseHelper databaseHelper = DatabaseHelper();
  EnquiryCRUD enquiryCRUD = EnquiryCRUD();
  QualificationList? _qualificationOption;
  String cleadQualification = "";
  late List<QualificationList> qualificationItems = [];
   List<EnquiryList> enquiryList=[];
  int? count;
  bool _search = false;
  bool _selected = false;

  void getPermissionUser() async {
    await Permission.phone.request();
  }

  @override
  void initState() {
    getLeadQualiFicationList("").then((value) {
      setState(() {
        this.qualificationItems = value!.qualificationList!;
      });
    });
    getPermissionUser();
    updateEnquiryListView(0, "");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new WillPopScope(
      onWillPop: () async => false,
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
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search',
                    ),
                    onChanged: (text) {
                      updateEnquiryListView(0, text);
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
              onTap: () {
                if (widget.select) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(title: "CRM")));
                }
              }),
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
            SizedBox(
              height: 5,
            ),
            DropdownButtonFormField<QualificationList>(
              isExpanded: true,
              decoration: InputDecoration(
                  labelText: 'Filter By Qualification',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.grey[600])),
              value: _qualificationOption,
              items: qualificationItems.map((QualificationList option) {
                return DropdownMenuItem<QualificationList>(
                  value: option,
                  child: Text(option.vqualification!),
                );
              }).toList(),
              onChanged: (QualificationList? newOption) {
                setState(() {
                  _qualificationOption = newOption;
                  if (newOption != null) {
                    this.cleadQualification = newOption!.clead_qualification!;
                    updateEnquiryListView(0, "");
                  }
                });
              },
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: this.enquiryList.length > 0
                  ? Scrollbar(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: count,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Material(
                                    elevation: 30.0,
                                    shadowColor: Colors.purple,
                                    child: GestureDetector(
                                      onTap: () async {
                                        int ienquiry_id = 0;
                                        String vcustomer_name = "";
                                        String vcode = "Default";
                                        if (enquiryList![index].vcustomerName !=
                                                null &&
                                            enquiryList![index].id != null) {
                                          ienquiry_id = enquiryList![index].id!;
                                          vcustomer_name = enquiryList![index]
                                              .vcustomerName!;
                                          vcode = enquiryList![index]
                                              .vpropertyEnquiryCode!;
                                        }
                                        //checks if the list is used as a select list
                                        if (widget.select) {
                                          Navigator.of(context).pop(
                                              IntSelectData(ienquiry_id,
                                                  vcustomer_name, ""));
                                        } else {
                                          bool reloadEnquiry;
                                          reloadEnquiry = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EnquiryPage(
                                                          title: vcustomer_name,
                                                          id: ienquiry_id)));
                                          if (reloadEnquiry) {
                                            updateEnquiryListView(0, "");
                                          }
                                        }
                                      },
                                      child: ListTile(
                                        leading: IconButton(
                                          icon: new Icon(Icons.call),
                                          highlightColor: Colors.pink,
                                          onPressed: () async {
                                            await call(enquiryList[index]
                                                    .vcustomerMobile1!)
                                                .then((value) {
                                              if (value == true) {
                                                PhoneState.phoneStateStream
                                                    .listen((event) {
                                                  print("Phone stream $event");
                                                  if (event != null) {
                                                    print(
                                                        "phone status function $event");
                                                    status = event;
                                                    if (event ==
                                                        PhoneStateStatus
                                                            .CALL_ENDED) {
                                                      getCallLogs(
                                                          enquiryList![index]
                                                              .id!);
                                                    }
                                                    // switch (event) {
                                                    //   case PhoneStateStatus
                                                    //       .CALL_STARTED:
                                                    //     print(
                                                    //         "phone status function $event");
                                                    //     break;
                                                    //   case :
                                                    //     print(
                                                    //         "phone status function $event");
                                                    //
                                                    //     break;
                                                    // }
                                                  }
                                                });
                                              }
                                            });
                                          },
                                        ),
                                        title: Text(
                                            '${enquiryList![index].vcustomerName}'),
                                        // subtitle:Text('Item description $status'),
                                      ),
                                    )),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            );
                          }))
                  : Center(
                      child:count==null? CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
                      ):Text("No Records Found"),
                    ),
            ))
            // // color: Colors.white,
          ]),
          // ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            debugPrint('FAB clicked');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnquiryGenerationPage(
                          title: 'Add Enquiry',
                          enquiryList: [],
                          fromEnq: false,
                        )));
          },
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void updateEnquiryListView(int mode, String vcustomer_name) async {
    /*--- Get Enquiry List Online-----*/
    await getEnquiryList(0, vcustomer_name, this.cleadQualification)
        .then((value) {
      setState(() {
        this.enquiryList = value!.enquiryList!;
        this.count = enquiryList.length;
      });
    });
/*--- Get Enquiry List Offline-----*/
    // final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    // dbFuture.then((database) {
    //   Future<List<EnquiryList>> enquiryListFuture =
    //       enquiryCRUD.getEnquiryList(mode, null);
    //   enquiryListFuture.then((enquiryListFuture) {
    //     setState(() {
    //       this.enquiryList = enquiryListFuture;
    //       this.count = enquiryListFuture.length;
    //     });
    //   });
    // });
  }
}
