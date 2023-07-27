
import 'package:crm/views/crm_manager/source_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/DateUtility/date_utils.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/string_select_data.dart';
import '../../models/crm/billboard_master_model.dart';
import '../../models/crm/enquiry_generation_master_model.dart';
import '../../models/crm/enquiry_source_model.dart';
import '../../models/crm/lead_qualification_master_model.dart';
import '../../models/crm/payment_terms_master_model.dart';
import '../../models/crm/property_booking_agent_model.dart';
import '../../models/user_management/city_model.dart';
import '../../models/human_resource/employee_master_model.dart';
import '../../models/common/int_select_data.dart';
import '../../models/property/property_master_model.dart';
import '../home/home_page.dart';
import '../human_resource/EmployeeList.dart';
import '../property/property_list.dart';
import '../user_management/city_list.dart';
import '../user_management/country_list.dart';
import 'agent_list.dart';
import 'enquiry_list.dart';
import 'lead_qualificationList.dart';

class EnquiryGenerationPage extends StatefulWidget {
  EnquiryGenerationPage(
      {Key? key,
      required this.title,
      required this.enquiryList,
      required this.fromEnq})
      : super(key: key);
  final String title;
  final bool fromEnq;
  final List<EnquiryList> enquiryList;
  @override
  _EnquiryGenerationPageState createState() => _EnquiryGenerationPageState();
}

class _EnquiryGenerationPageState extends State<EnquiryGenerationPage> {
  @override
  void initState() {
    // TODO: implement initState
    _fetchData();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  //initialize drop down list values and model
  PaymentTermsList? _paymentOption;
  BillBoardList? _billBoardOption;
  late List<SourceList> sourceItems = [];
  late List<PropertyList> propertyItems = [];
  late List<PaymentTermsList> paymentItems = [];
  late List<QualificationList> qualificationItems = [];
  late List<CityList> cityItems = [];
  late List<AgentList> agentItems = [];
  late List<BillBoardList> billBoardItems = [];
  late List<BillBoardList> billboardItems = [];
  late List<EmployeeMasterList> employeeItems = [];

  //fetch select list
  Future _fetchData() async {
    setState(() {
      if (widget.enquiryList != null && widget.enquiryList.length > 0) {
        this.inacId= widget.enquiryList?[0].inac_id ?? 0;
        this.icpdId= widget.enquiryList?[0].icpd_id ?? 0;
        this.vtaxNo=widget.enquiryList?[0].vtax_no ?? "";
        vcustomer_nameController.text =
            widget.enquiryList?[0].vcustomerName ?? "";
        vcustomer_mobile1Controller.text =
            widget.enquiryList?[0].vcustomerMobile1 ?? "";
        vcustomer_email_addressController.text =
            widget.enquiryList?[0].vcustomerEmailAddress ?? "";
        mour_offerController.text =
            widget.enquiryList?[0].mourOffer.toString() ?? "";
        this.ilead_source = widget.enquiryList?[0].ileadSource ?? 0;
        this.ipayment_terms_id = widget.enquiryList?[0].ipaymentTermsId ?? 0;
        this.iproperty_id = widget.enquiryList?[0].ipropertyId ?? 0;
        propertyController.text = widget.enquiryList?[0].vpropertyName ?? "";
        this.clead_qualification =
            widget.enquiryList?[0].cleadQualification ?? "";
        this.vagent_code = widget.enquiryList?[0].vagentCode ?? "";
        agentController.text = widget.enquiryList?[0].vagentName ?? "";
        this.vemp_code = widget.enquiryList?[0].vleadBy ?? "";
        vlead_byController.text = widget.enquiryList?[0].vleadByName ?? "";
        this.ibillboard_location_id =
            widget.enquiryList?[0].ibillboardLocationId ?? 0;
        this.city_id = widget.enquiryList?[0].cityId ?? 0;
        cityController.text = widget.enquiryList?[0].cityName ?? "";
        vremarksController.text = widget.enquiryList?[0].vremarks ?? "";
        qualificationController.text = widget.enquiryList?[0].vstatusName ?? "";
        this.clead_qualification =
            widget.enquiryList?[0].cleadQualification ?? "";
        sourceController.text = widget.enquiryList?[0].venquirySource ?? "";
        this.ilead_source = widget.enquiryList?[0].ileadSource ?? 0;
        vcustomer_addressController.text =
            widget.enquiryList?[0].vcustomerAddress ?? "";
        enquiry.id = widget.enquiryList?[0].id ?? null;
        _datecontroller.text = widget.enquiryList?[0].venquiryDate ?? "";
        vcustomer_mobile2Controller.text =
            widget.enquiryList?[0].vcustomerMobile2 ?? "";
        countryController.text =
            "${widget.enquiryList?[0].vcountryName ?? ""}(${widget.enquiryList?[0].vcountryCode ?? ""})";
        this.icountry_id = widget.enquiryList?[0].icountryId ?? 0;
        this.vtempCustomerCode= widget.enquiryList?[0].vtempCustomerCode ?? "";
        enquiry.vtempCustomerCode=this.vtempCustomerCode;
        vcustomer_email_address2Controller.text=widget.enquiryList?[0].vcustomerEmailAddress2 ?? "";
      }
    });

    await getPaymentTermsList().then((value) {
      setState(() {
        this.paymentItems = value!.paymentTermsList!;
        if (widget.enquiryList.length > 0 && this.ipayment_terms_id > 0) {
          _paymentOption = paymentItems.isNotEmpty
              ? paymentItems
                  .firstWhere((element) => element.id == this.ipayment_terms_id)
              : null;
        }
      });
    });

    await getBilboardLocationList().then((value) {
      setState(() {
        this.billBoardItems = value!.billBoardList!;
        if (widget.enquiryList.length > 0 && this.ibillboard_location_id > 0) {
          _billBoardOption = billBoardItems.isNotEmpty
              ? billBoardItems.firstWhere(
                  (element) => element.id == this.ibillboard_location_id)
              : null;
        }
      });
    });
  }

  TextEditingController _datecontroller = new TextEditingController();
  var myFormat = DateFormat('d/MM/yyyy');
  DateTime date = DateTime.now();
  EnquiryCRUD helper = EnquiryCRUD();
  EnquiryList enquiry = new EnquiryList(
      null,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      0,
      0,
      0,
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      0,
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      0,
      0,
      "",
      "",
      "",
      "");
  String header = "";
  int iproperty_id = 0;
  int icountry_id = 0;
  int ilead_source = 0;
  int ipayment_terms_id = 0;
  int city_id = 0;
  int ibillboard_location_id = 0;
  String vtaxNo= "";
  int inacId=0;
  int icpdId=0;
  String vagent_code = "";
  String clead_qualification = "";
  String vemp_code = "";
  String vproperty_enquiry_code = "";
  String vtempCustomerCode = "";
  DateTime? selectedDate;
  late StringSelectData agentData;
  late IntSelectData leadData;
  late StringSelectData qualificationData;
  late IntSelectData cityData;
  late IntSelectData propertyData;
  late IntSelectData countryData;
  late IntSelectData sourceData;
  late IntSelectData billboardData;
  late IntSelectData paymentData;
  late StringSelectData leadByData;
  late IntSelectData enquiryData;
  TextEditingController vcustomer_nameController = TextEditingController();
  TextEditingController vcustomer_addressController = TextEditingController();
  TextEditingController vpermanent_cityController = TextEditingController();
  TextEditingController vcustomer_mobile1Controller = TextEditingController();
  TextEditingController vcustomer_mobile2Controller = TextEditingController();
  TextEditingController vcustomer_email_addressController =
      TextEditingController();
  TextEditingController vcustomer_email_address2Controller =
      TextEditingController();
  TextEditingController vproperty_enquiry_codeController =
      TextEditingController();
  TextEditingController vtemp_customer_codeController = TextEditingController();
  TextEditingController mour_offerController = TextEditingController();
  TextEditingController vremarksController = TextEditingController();
  TextEditingController vagent_codeController = TextEditingController();
  TextEditingController vlead_byController = TextEditingController();
  TextEditingController vcreated_byController = TextEditingController();
  TextEditingController vupdated_byController = TextEditingController();
  TextEditingController agentController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController leadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (sourceItems == null) {
      _fetchData();
    }
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
                  if (widget.fromEnq) {
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
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.purpleAccent,
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller: vcustomer_nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Name',
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
                                        countryData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CountryListPage(
                                                      title: 'Country  List',
                                                      select: true,
                                                    )));
                                        getCountryData(countryData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    enabled: true,
                                    controller: countryController,
                                    validator: (value) {
                                      if (icountry_id <= 0) {
                                        return 'Please Select Country Code';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      labelText: 'Country Code',
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
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.purpleAccent,
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller: vcustomer_mobile1Controller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Phone Number';
                                      }
                                      if (double.tryParse(value!) == null) {
                                        return 'Please enter a numeric value';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // hintText: 'Enter Lead Phone Number',
                                      // helperText: 'Enter the number after the code',
                                      labelText: 'Phone Number',
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
                                      icon: Icon(
                                        Icons.mail_outline,
                                        color: Colors.purpleAccent,
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    controller:
                                        vcustomer_email_addressController,
                                    obscuringCharacter: '*',
                                    decoration: new InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      labelText: 'Email Address',
                                      labelStyle: new TextStyle(
                                          color: Colors.grey[600]),
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
                                      _datecontroller.text =
                                          (await getDatePicker(context))!;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    enabled: true,
                                    controller: _datecontroller,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please Select Date';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      labelText: 'Enquiry Date',
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
                                      icon: Icon(
                                        Icons.monetization_on,
                                        color: Colors.purpleAccent,
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller: mour_offerController,
                                    obscuringCharacter: '*',
                                    validator: (value) {
                                      if (double.tryParse(value!) == null) {
                                        return 'Please enter a numeric value';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                        focusedBorder: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.purple[100]!)),
                                        hintText: 'Enter Product Price',
                                        labelText: 'Our Offer',
                                        labelStyle:
                                            TextStyle(color: Colors.grey[600]),
                                        suffixText: 'Ksh.',
                                        suffixStyle: const TextStyle(
                                            color: Colors.purple)),
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
                                        qualificationData =
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LeadQualificationListPage(
                                                          title:
                                                              'Lead Qualification List',
                                                          select: true,
                                                        )));
                                        if (qualificationData != null) {
                                          getQualificationData(
                                              qualificationData);
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    enabled: true,
                                    controller: qualificationController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          clead_qualification.isEmpty) {
                                        return 'Please Select Qualification';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Lead Qualification',
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
                                        propertyData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    PropertyListPage(
                                                      title: 'Property  List',
                                                      select: true, units: false,
                                                    )));

                                        getPropertyData(propertyData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    enabled: true,
                                    controller: propertyController,
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
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Property Name',
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
                                        sourceData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SourceListPage(
                                                      title: 'Source  List',
                                                      select: true,
                                                    )));

                                        getSourceData(sourceData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    enabled: true,
                                    controller: sourceController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          ilead_source == 0) {
                                        return 'Please Select Source';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Enquiry Source',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      prefixText: ' ',
                                    ),
                                  ))
                                ]),
                            SizedBox(
                              height: height * 0.008,
                            ),
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
                                        cityData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CityListPage(
                                                      title: 'City  List',
                                                      select: true,
                                                    )));

                                        getCityData(cityData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    enabled: true,
                                    controller: cityController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          city_id == 0) {
                                        return 'Please Select City';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'City Name',
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
                                        leadByData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    EmployeeListPage(
                                                      title: 'Employee  List',
                                                      select: true,
                                                    )));

                                        getEmpData(leadByData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    enabled: true,
                                    controller: vlead_byController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          vemp_code.isEmpty) {
                                        return 'Please Select Lead By';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Lead By',
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
                                        leadData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => EnquiryListPage(
                                                      title: 'Enquiry List',
                                                      select: true,
                                                    )));

                                        getEnquiryData(leadData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    enabled: true,
                                    controller: leadController,
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Associated Enquiry',
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
                                        agentData = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => AgentListPage(
                                                      title: 'Agent  List',
                                                      select: true,
                                                    )));

                                        getAgentData(agentData);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    enabled: true,
                                    controller: agentController,
                                    decoration: InputDecoration(
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.purple[100]!)),
                                      // helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Agent Name',
                                      labelStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      prefixText: ' ',
                                    ),
                                  ))
                                ]),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            DropdownButtonFormField<BillBoardList>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  focusedBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.purple[100]!)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Bill Board',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600])),
                              value: _billBoardOption,
                              items: billBoardItems.map((BillBoardList option) {
                                return DropdownMenuItem<BillBoardList>(
                                  value: option,
                                  child: Text(option.vbillboard_location!),
                                );
                              }).toList(),
                              onChanged: (BillBoardList? newOption) {
                                setState(() {
                                  _billBoardOption = newOption;
                                  if (newOption != null) {
                                    this.ibillboard_location_id =
                                        newOption!.id!;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            DropdownButtonFormField<PaymentTermsList>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  focusedBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.purple[100]!)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Payment Terms',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600])),
                              value: _paymentOption,
                              items:
                                  paymentItems.map((PaymentTermsList option) {
                                return DropdownMenuItem<PaymentTermsList>(
                                  value: option,
                                  child: Text(option.vpaymentTermName!),
                                );
                              }).toList(),
                              onChanged: (PaymentTermsList? newOption) {
                                setState(() {
                                  _paymentOption = newOption;
                                  if (newOption != null) {
                                    this.ipayment_terms_id = newOption!.id!;
                                    // print(newOption!.id!);
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            TextField(
                              controller: vremarksController,
                              decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.purple[100]!)),
                                // helperText: 'Keep it short, this is just a demo.',
                                labelText: 'Remarks',
                                labelStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            TextField(
                              controller: vcustomer_addressController,
                              decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.purple[100]!)),
                                // helperText: 'Keep it short, this is just a demo.',
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            TextField(
                              controller: vcustomer_mobile2Controller,
                              decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.purple[100]!)),
                                // helperText: 'Keep it short, this is just a demo.',
                                labelText: 'Alternative Phone Number',
                                labelStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            SizedBox(
                              height: height * 0.008,
                            ),
                            TextField(
                              controller: vcustomer_email_address2Controller,
                              decoration: InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.purple[100]!)),
                                // helperText: 'Keep it short, this is just a demo.',
                                labelText: 'Alternative Email',
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
    print('starting the process-----');
    if (_formKey.currentState!.validate()) {
      print('starting the validation-----');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving Data')),
      );

      enquiry.vcustomerName = vcustomer_nameController.text;
      enquiry.vcustomerAddress = vcustomer_addressController.text;
      enquiry.vcustomerMobile1 = vcustomer_mobile1Controller.text;
      enquiry.vcustomerMobile2 = vcustomer_mobile2Controller.text;
      enquiry.vcustomerEmailAddress = vcustomer_email_addressController.text;
      enquiry.vcustomerEmailAddress2 = vcustomer_email_address2Controller.text;
      enquiry.denquiryDate = _datecontroller.text;
      enquiry.mourOffer = double.parse(mour_offerController.text);
      enquiry.vremarks = vremarksController.text;
      enquiry.vagentCode = this.vagent_code;
      enquiry.vleadBy = this.vemp_code;
      enquiry.finYear = '2023';
      enquiry.vcreatedBy = null;
      enquiry.vupdatedBy = null;
      enquiry.dupdatedDate = null;
      enquiry.cstatus = "A";
      enquiry.cenquiryStatus;
      enquiry.cleadQualification = this.clead_qualification;
      enquiry.cityId = this.city_id;
      enquiry.ibillboardLocationId = this.ibillboard_location_id;
      enquiry.ipropertyId = this.iproperty_id;
      enquiry.ileadSource = this.ilead_source;
      enquiry.ipaymentTermsId = this.ipayment_terms_id;
      enquiry.icountryId = this.icountry_id;
      enquiry.inac_id= this.inacId;
      enquiry.vtax_no=this.vtaxNo;
      enquiry.icpd_id=this.icpdId;
      print("Saving_________________3");
      int result = 0;
      int? response;
      String? vtempCustomerCode;
      EnquiryGenerationMasterModel? model;
      if (enquiry.id != null && enquiry.id! > 0) {
        print("Updating_________________4");
        // Case 1: Update operation
        // result = await helper.updateEnquiry(enquiry);
        await addNewActivityCustomer(enquiry).then((value) {
          enquiry.vtempCustomerCode = this.vtempCustomerCode;
          addEnquiry(enquiry).then((value) {
            response = value;
            if (response! > 0) {
              print('enquiry Saved Successfully'); // Success
              // _showAlertDialog('Status', 'enquiry Saved Successfully');
              if (widget.fromEnq) {
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
        // Case 2: Insert Operation
        /*--- Add Enquiry Offline-----*/
        // result = await helper.insertEnquiry(enquiry);

        /*---------Adding Enquiry Online----------*/
        await addNewActivityCustomer(enquiry).then((value) {
          enquiry.vtempCustomerCode = value;
          addEnquiry(enquiry).then((value) {
            response = value;
            if (response! > 0) {
              print('enquiry Saved Successfully'); // Success
              // _showAlertDialog('Status', 'enquiry Saved Successfully');
              if (widget.fromEnq) {
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
            builder: (context) => EnquiryListPage(
                  title: "Leads", select: false,
                )));
  }

  getAgentData(StringSelectData selectData) {
    setState(() {
      agentController.text = selectData.vname;
      vagent_code = selectData.vcode;
    });
  }

  getEnquiryData(IntSelectData selectData) {
    setState(() {
      leadController.text = selectData.vname;
      vproperty_enquiry_code = selectData.vcode;
    });
  }

  getQualificationData(StringSelectData selectData) {
    setState(() {
      qualificationController.text = selectData.vname;
      clead_qualification = selectData.vcode;
    });
  }

  getEmpData(StringSelectData selectData) {
    setState(() {
      vlead_byController.text = selectData.vname;
      vemp_code = selectData.vcode;
    });
  }

  getPropertyData(IntSelectData selectData) {
    setState(() {
      propertyController.text = selectData.vname;
      iproperty_id = selectData.id;
    });
  }

  getCountryData(IntSelectData selectData) {
    setState(() {
      countryController.text = selectData.vname;
      icountry_id = selectData.id;
    });
  }

  getSourceData(IntSelectData selectData) {
    setState(() {
      sourceController.text = selectData.vname;
      ilead_source = selectData.id;
    });
  }

  getCityData(IntSelectData selectData) {
    setState(() {
      cityController.text = selectData.vname;
      city_id = selectData.id;
    });
  }
}
