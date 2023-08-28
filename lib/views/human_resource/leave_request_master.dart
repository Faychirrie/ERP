
import 'package:crm/views/human_resource/leave_request_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/DateUtility/date_utils.dart';
import '../../controllers/online_crud_operations/human_resource_online_crud.dart';
import '../../models/common/string_select_data.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import '../../models/human_resource/leave_request_master_model.dart';
import '../../models/human_resource/leave_type_category_model.dart';
import '../../models/human_resource/employee_master_model.dart';
import '../../models/common/int_select_data.dart';
import '../human_resource/employee_list.dart';
import '../user_management/business_area_list.dart';
import 'leave_type_category.dart';
class LeaveRequestMasterPage extends StatefulWidget {
  LeaveRequestMasterPage(
      {Key? key,
        required this.title,
        required this.enquiryList, required this.edit
      })
      : super(key: key);
  final String title;
  final bool edit;
  final List<EnquiryList> enquiryList;
  @override
  _LeaveRequestMasterPageState createState() => _LeaveRequestMasterPageState();
}

class _LeaveRequestMasterPageState extends State<LeaveRequestMasterPage> {
  @override
  void initState() {
    // TODO: implement initState
    _fetchData();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  //initialize drop down list values and model
  late List<LeaveCategoryList> leaveCategoryItems = [];
  late List<EmployeeMasterList> employeeItems = [];

  //fetch select list
  Future _fetchData() async {
    setState(() {
      // if (widget.enquiryList != null && widget.enquiryList.length > 0) {
      //   this.inacId= widget.enquiryList?[0].inac_id ?? 0;
      //   this.icpdId= widget.enquiryList?[0].icpd_id ?? 0;
      //   this.vtaxNo=widget.enquiryList?[0].vtax_no ?? "";
      //   vcustomer_nameController.text =
      //       widget.enquiryList?[0].vcustomerName ?? "";
      //   vcustomer_mobile1Controller.text =
      //       widget.enquiryList?[0].vcustomerMobile1 ?? "";
      //   this.ilead_source = widget.enquiryList?[0].ileadSource ?? 0;
      //   this.ipayment_terms_id = widget.enquiryList?[0].ipaymentTermsId ?? 0;
      //   this.iproperty_id = widget.enquiryList?[0].ipropertyId ?? 0;
      //   this.clead_qualification =
      //       widget.enquiryList?[0].cleadQualification ?? "";
      //   this.vagent_code = widget.enquiryList?[0].vagentCode ?? "";
      //   this.vemp_code = widget.enquiryList?[0].vleadBy ?? "";
      //   this.ibillboard_location_id =
      //       widget.enquiryList?[0].ibillboardLocationId ?? 0;
      //   this.city_id = widget.enquiryList?[0].cityId ?? 0;
      //   this.clead_qualification =
      //       widget.enquiryList?[0].cleadQualification ?? "";
      //   this.ilead_source = widget.enquiryList?[0].ileadSource ?? 0;
      //   vcustomer_addressController.text =
      //       widget.enquiryList?[0].vcustomerAddress ?? "";
      //   enquiry.id = widget.enquiryList?[0].id ?? null;
      //   _datecontroller.text = widget.enquiryList?[0].venquiryDate ?? "";
      //   vcustomer_mobile2Controller.text =
      //       widget.enquiryList?[0].vcustomerMobile2 ?? "";
      //   this.icountry_id = widget.enquiryList?[0].icountryId ?? 0;
      //   this.vtempCustomerCode= widget.enquiryList?[0].vtempCustomerCode ?? "";
      //   enquiry.vtempCustomerCode=this.vtempCustomerCode;
      // }
    });
  }
  TextEditingController _fromDatecontroller = new TextEditingController();
  TextEditingController _toDatecontroller = new TextEditingController();
  var myFormat = DateFormat('d/MM/yyyy');
  DateTime date = DateTime.now();
  LeaveRequestMasterModel leave = new LeaveRequestMasterModel(0, "_ddate", 0, "_vbusinessAreaShortName", "_vempCode", "_vhandoverEmpCode", "_vhandoverEmpCodeTo", "_vleaveRequestCode", "_vreason", "_vreferenceNo", "_capprovedStatus", "_cstatus", "_dcreatedDate", "", "", 0, "", 0, 0, 0);
  String header = "";
  String vleaveRequestCode = "";
  String vbusinessAreaShortName = "";
  String vhandoverEmpCode = "";
  String vhandoverEmpCodeTo = "";
  int ibusinessAreaId = 0;
  int ileaveType = 0;
  DateTime? selectedDate;
  late IntSelectData leaveTypeData;
  late IntSelectData businessAreaData;
  late StringSelectData applicantData;
  late StringSelectData handoverData;
  TextEditingController vleaveCategoryName = TextEditingController();
  TextEditingController vbusinessAreaName = TextEditingController();
  TextEditingController vapplicantName = TextEditingController();
  TextEditingController vhandoverName = TextEditingController();
  TextEditingController ileaveCountType = TextEditingController();
  TextEditingController mleaveCount = TextEditingController();
  TextEditingController vreferenceNo = TextEditingController();
  TextEditingController vreason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // if (sourceItems == null) {
    //   _fetchData();
    // }
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.purple,
            leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: () {
                  if (widget.edit) {
                    Navigator.pop(context);

                  } else {
                    moveToHome();
                  }
                }),
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
                    }),
              ),
            ],
          ),
          body: SafeArea(
              child: Form(
                key: _formKey,
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
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.purpleAccent,
                                          ),
                                          onPressed: () async {
                                            businessAreaData = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        BusinessAreaListPage(
                                                          title: 'Bussiness Area  List',
                                                          select: true, items: false,
                                                        )));

                                            getBusinessAreaData(businessAreaData);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: TextField(
                                            enabled: true,
                                            controller: vbusinessAreaName,
                                            decoration: InputDecoration(
                                              focusedBorder: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.purple[100]!)),
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: 'Business Area',
                                              labelStyle:
                                              TextStyle(color: Colors.grey[600]),
                                              prefixText: ' ',
                                            ),
                                          )),
                                    ]),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.purpleAccent,
                                          ),
                                          onPressed: () async {
                                            leaveTypeData = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LeaveTypeCategoryPage(
                                                          title: 'Leave Type',
                                                          select: true, units: false,
                                                        )));

                                            getLeaveTypeData(leaveTypeData);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: TextField(
                                            enabled: true,
                                            controller: vleaveCategoryName,
                                            // validator: (value) {
                                            //   if (value == null ||
                                            //       value.isEmpty ||
                                            //       iproperty_id == 0) {
                                            //     return 'Please Select Property';
                                            //   }
                                            //   return null;
                                            // },
                                            decoration: InputDecoration(
                                              focusedBorder: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.purple[100]!)),
                                              labelText: 'Leave Type',
                                              labelStyle:
                                              TextStyle(color: Colors.grey[600]),
                                              prefixText: ' ',
                                            ),
                                          )),
                                    ]),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.purpleAccent,
                                          ),
                                          onPressed: () async {
                                            applicantData = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>EmployeeListPage(
                                                      title: 'Applicant',
                                                      select: true,
                                                    )));

                                            getApplicantData(applicantData);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            enabled: true,
                                            controller: vapplicantName,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Select Applicant';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.purple[100]!)),
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: 'Applicant',
                                              labelStyle:
                                              TextStyle(color: Colors.grey[600]),
                                              prefixText: ' ',
                                            ),
                                          ))
                                    ]),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.purpleAccent,
                                          ),
                                          onPressed: () async {
                                            handoverData = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>  EmployeeListPage(
                                                      title: 'Handover Employee',
                                                      select: true,
                                                    )));

                                            getHandoverData(handoverData);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            enabled: true,
                                            controller: vhandoverName,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ) {
                                                return 'Please Select Handover';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.purple[100]!)),
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: 'Handover Employee',
                                              labelStyle:
                                              TextStyle(color: Colors.grey[600]),
                                              prefixText: ' ',
                                            ),
                                          ))
                                    ]),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.purpleAccent,
                                          ),
                                          onPressed: () async {
                                            handoverData = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>  EmployeeListPage(
                                                      title: 'Handover Employee 2',
                                                      select: true,
                                                    )));

                                            getHandoverData(handoverData);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                            enabled: true,
                                            controller: vhandoverName,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ) {
                                                return 'Please Select Handover Employee 2';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              focusedBorder: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.purple[100]!)),
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: 'Handover Employee 2',
                                              labelStyle:
                                              TextStyle(color: Colors.grey[600]),
                                              prefixText: ' ',
                                            ),
                                          ))
                                    ]),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: FractionalOffset.centerRight,
                                      child: IconButton(
                                        icon: new Icon(Icons.event_note,
                                            color: Colors.purpleAccent),
                                        onPressed: () async {
                                          // _showDatePicker(context);
                                          _fromDatecontroller.text =
                                          (await getDatePicker(context))!;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        enabled: true,
                                        controller: _fromDatecontroller,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please Select From Date';
                                          }
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          focusedBorder: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.purple[100]!)),
                                          labelText: 'From Date',
                                          labelStyle: new TextStyle(
                                              color: Colors.grey[600]),
                                          // prefixIcon: '',
                                          // prefixText: ' ',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: FractionalOffset.centerRight,
                                      child: IconButton(
                                        icon: new Icon(Icons.event_note,
                                            color: Colors.purpleAccent),
                                        onPressed: () async {
                                          // _showDatePicker(context);
                                          _toDatecontroller.text =
                                          (await getDatePicker(context))!;
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        enabled: true,
                                        controller: _toDatecontroller,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please Select To Date';
                                          }
                                          return null;
                                        },
                                        decoration: new InputDecoration(
                                          focusedBorder: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.purple[100]!)),
                                          labelText: 'To Date',
                                          labelStyle: new TextStyle(
                                              color: Colors.grey[600]),
                                          // prefixIcon: '',
                                          // prefixText: ' ',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                TextField(
                                  controller: vreason,
                                  decoration: InputDecoration(
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.purple[100]!)),
                                    labelText: 'Reason',
                                    labelStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                TextField(
                                  controller: vreferenceNo,
                                  decoration: InputDecoration(
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.purple[100]!)),
                                    // helperText: 'Keep it short, this is just a demo.',
                                    labelText: 'Reference No',
                                    labelStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                TextField(
                                  controller: ileaveCountType,
                                  decoration: InputDecoration(
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.purple[100]!)),
                                    // helperText: 'Keep it short, this is just a demo.',
                                    labelText: 'Leave Count Type',
                                    labelStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                                TextField(
                                  controller: mleaveCount,
                                  decoration: InputDecoration(
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.purple[100]!)),
                                    // helperText: 'Keep it short, this is just a demo.',
                                    labelText: 'Leave Count',
                                    labelStyle: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.008,
                                ),
                              ],
                            ),
                          )))
                ]),
              ))),
    );
  }

  void _save() async {
    print('starting saving process-----');
    if (_formKey.currentState!.validate()) {
      print('starting the validation-----');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving Data')),
      );
      //Master
      leave.ibusinessAreaId= this.ibusinessAreaId;
      leave.ddate=_fromDatecontroller.text;
      leave.vhandoverEmpCode=this.vhandoverEmpCode;
      leave.vhandoverEmpCodeTo=this.vhandoverEmpCodeTo;
      leave.vreason=vreason.text;
      leave.vreferenceNo=vreferenceNo.text;

      //Detail
      leave.ileaveType=this.ileaveType;
      leave.ileaveCountType=int.parse(ileaveCountType.text);
      leave.mleaveCount=double.parse(mleaveCount.text);

      print("Saving_________________3");
      int result = 0;
      int? response;
      if (leave.id != null && leave.id! > 0) {
        print("Updating_________________4");
        await addLeaveRequestMaster(leave).then((value) {
          leave.vleaveRequestCode = value;
          addLeaveRequestDetail(leave).then((value) {
            response = value;
            if (response! > 0) {
              print('enquiry Saved Successfully'); // Success
              // _showAlertDialog('Status', 'enquiry Saved Successfully');
              if (widget.edit) {
                // Navigator.pop(context);
                Navigator.of(context).pop(true);
              } else {
                moveToHome();
              }
            }
          });
        });
      } else {
        print("Saving_________________5");
        await addLeaveRequestMaster(leave).then((value) {
          leave.vleaveRequestCode = value;
          addLeaveRequestDetail(leave).then((value) {
            response = value;
            if (response! > 0) {
              print('enquiry Saved Successfully'); // Success
              if (widget.edit) {
                Navigator.pop(context);
              } else {
                moveToHome();
              }
            }
          });
        });

        // response = await addEnquiry(enquiry);
      }

      if (result != 0) {
        print('enquiry Saved Successfully'); // Success
        // _showAlertDialog('Status', 'enquiry Saved Successfully');
        moveToHome();
      } else {
        // Failure
        print('Problem Saving enquiry');
        // _showAlertDialog('Status', 'Problem Saving Note');
      }
    }
  }

  void moveToHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LeaveRequestListPage(
              title: "Leads",activityMode: 0,
            )));
  }

  //Setting Select List Data
  getApplicantData(StringSelectData selectData) {
    setState(() {
      vapplicantName.text = selectData.vname;
      vhandoverEmpCode = selectData.vcode;
    });
  }
  getHandoverData(StringSelectData selectData) {
    setState(() {
      vhandoverName.text = selectData.vname;
      vhandoverEmpCodeTo = selectData.vcode;
    });
  }
  getLeaveTypeData(IntSelectData selectData) {
    setState(() {
      vleaveCategoryName.text = selectData.vname;
      ileaveType = selectData.id;
    });
  }
  getBusinessAreaData(IntSelectData selectData) {
    setState(() {
      vbusinessAreaName.text = selectData.vname;
      ibusinessAreaId = selectData.id;
    });
  }
}
