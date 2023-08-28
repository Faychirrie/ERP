import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/property_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/property/property_master_model.dart';
import '../../models/property/property_units_model.dart';
import '../home/home_page.dart';

class UnitListPage extends StatefulWidget {
  UnitListPage(
      {Key? key,
      required this.title,
      required this.select,
      required this.units,
      required this.ipropertyId})
      : super(key: key);
  final String title;
  final bool select;
  final bool units;
  final int ipropertyId;
  @override
  _UnitListPageState createState() => _UnitListPageState();
}

class _UnitListPageState extends State<UnitListPage> {
  List<UnitList>? unitList = [];
  int? count;
  bool _search = false;
  String ccurent_status = "";
  List<dynamic> statusList = [];

  @override
  void initState() {
    this.statusList.add({"ccurent_status": 'A', "label": "Available"});
    this.statusList.add({"ccurent_status": 'B', "label": "Booked"});
    this.statusList.add({"ccurent_status": 'S', "label": "Sold"});
    updateListView(widget.ipropertyId, "");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                      updateListView(0, text);
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
                if (widget.select || widget.units) {
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
                : Container(),
          ],
          // automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 5,
            ),
            FormHelper.dropDownWidget(context, "Filter By Status",
                this.ccurent_status, this.statusList, (onchangeVal) {
              setState(() {
                this.ccurent_status = onchangeVal;
              });

              updateListView(widget.ipropertyId, "");
            }, (onValidate) {
              return null;
            },
                optionLabel: "label",
                optionValue: "ccurent_status",
                borderColor: Colors.white,
                borderRadius: 10),
            this.unitList!.length > 0
                ? Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Scrollbar(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: count,
                                itemBuilder: (BuildContext context, int index) {
                                  String status = "";
                                  Color textColor = Colors.black87;
                                  if (unitList![index].ccurrentStatus == 'S') {
                                    status = "Sold";
                                    textColor = Colors.red;
                                  } else if (unitList![index].ccurrentStatus ==
                                      'B') {
                                    status = "Booked";
                                    textColor = Colors.orange;
                                  } else {
                                    status = "Available";
                                    textColor = Colors.green;
                                  }
                                  return Column(
                                    children: [
                                      Material(
                                          elevation: 30.0,
                                          shadowColor: Colors.purple,
                                          child: GestureDetector(
                                            onTap: () {
                                              int cityId = 0;
                                              String cityName = "";

                                              if (unitList![index].id! > 0) {
                                                cityId = unitList![index].id!;
                                                cityName = unitList![index]
                                                    .vsetupName!;
                                              }
                                              if (widget.select) {
                                                Navigator.of(context).pop(
                                                    IntSelectData(
                                                        cityId, cityName, ""));
                                              }
                                            },
                                            child: ListTile(
                                                leading: Icon(
                                                  Icons.home,
                                                  color: unitList![index]
                                                              .ccurrentStatus ==
                                                          'S'
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                                title: Text(
                                                    '${unitList![index].vsetupName} ${unitList?[0].vfloorName ?? ""}'),
                                                subtitle: unitList![index]
                                                                .ccurrentStatus ==
                                                            'S' ||
                                                        unitList![index]
                                                                .ccurrentStatus ==
                                                            'B'
                                                    ? Text(
                                                        '$status (${unitList![index].vplantName})',
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: textColor),
                                                      )
                                                    : Text(
                                                        status,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: textColor),
                                                      )),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  );
                                }))))
                : Container(
                    child: this.count == null
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff880e4f)),
                          )
                        : Container(
                            child: Text("No Records Found !",
                                style: TextStyle(color: Colors.red)),
                          ),
                  ),
            // // color: Colors.white,
          ]),
          // ),
        ));
  }

  void updateListView(int id, String unitName) async {
    /*--- Get Agent List Online-----*/
    await getUnitList(id, this.ccurent_status).then((value) {
      print("ccurent_status");
      print(ccurent_status);
      setState(() {
        this.unitList = value!.unitList!;
        this.count = unitList!.length;
      });
      print("count");
      print(count);
    });
  }
}
