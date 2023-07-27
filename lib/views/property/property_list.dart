import 'package:flutter/material.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/property_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/property/property_master_model.dart';
import '../home/home_page.dart';
import 'list_of_units.dart';

class PropertyListPage extends StatefulWidget {
  PropertyListPage(
      {Key? key,
      required this.title,
      required this.select,
      required this.units})
      : super(key: key);
  final String title;
  final bool select;
  final bool units;
  @override
  _PropertyListPageState createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  EnquiryCRUD enquiryCRUD = EnquiryCRUD();
  List<PropertyList>? propertyList = [];
  int? count;
  bool _search = false;
  @override
  void initState() {
    updateListView(0, "");
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
      body: this.propertyList!.length > 0
          ? SafeArea(
              child: Column(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: this.propertyList!.length > 0
                            ? Scrollbar(
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: count,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Material(
                                              elevation: 30.0,
                                              shadowColor: Colors.purple,
                                              child: GestureDetector(
                                                onTap: () {
                                                  int propertId = 0;
                                                  String propertyName = "";
                                                  if (propertyList![index].id! >
                                                      0) {
                                                    propertId =
                                                        propertyList![index]
                                                            .id!;
                                                    propertyName =
                                                        propertyList![index]
                                                            .vpropertyName!;
                                                  }
                                                  if (widget.select) {
                                                    Navigator.of(context).pop(
                                                        IntSelectData(propertId,
                                                            propertyName, ""));
                                                  } else if (widget.units) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UnitListPage(
                                                                  title: '$propertyName Units',
                                                                  select: false, units: true, ipropertyId: propertId,
                                                                )));
                                                  }
                                                },
                                                child: ListTile(
                                                  title: Text(
                                                      '${propertyList![index].vpropertyName}'),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      );
                                    }))
                            : Container(
                                child: Text("No Entries"),
                              )))
                // // color: Colors.white,
              ]),
              // ),
            )
          : Center(
              child:count==null? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
              ):Text("No Records Found"),
            ),
    );
  }

  void updateListView(int id, String vpropertyName) async {
    /*--- Get Agent List Online-----*/
    await getPropertyList(vpropertyName).then((value) {
      setState(() {
        this.propertyList = value!.propertyList!;
        this.count = propertyList!.length;
      });
    });
  }
}
