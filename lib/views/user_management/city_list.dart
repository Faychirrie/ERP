

import 'package:flutter/material.dart';
import 'package:phone_state/phone_state.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/enquiry_crud.dart';
import '../../controllers/online_crud_operations/user_management_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/user_management/city_model.dart';
import '../home/home_page.dart';

class CityListPage extends StatefulWidget {
  CityListPage({Key? key, required this.title, required this.select})
      : super(key: key);
  final String title;
  final bool select;
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  PhoneStateStatus status = PhoneStateStatus.NOTHING;
  DatabaseHelper databaseHelper = DatabaseHelper();
  EnquiryCRUD enquiryCRUD = EnquiryCRUD();
  List<CityList> cityList = [];
  int count = 0;
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (cityList.isEmpty) {
      updateListView(0, "");
    }
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
      body: this.cityList!.length>0? SafeArea(
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: this.cityList.length > 0
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
                                      onTap: () {
                                        int cityId = 0;
                                        String cityName = "";
                                        if (cityList![index].city_id !>0) {
                                          cityId =
                                          cityList![index].city_id!;
                                          cityName =
                                          cityList![index]
                                              .cityName!;
                                        }
                                        if (widget.select) {
                                          Navigator.of(context).pop(
                                              IntSelectData(cityId,
                                                  cityName,""));
                                        }
                                      },
                                      child: ListTile(
                                 
                                        title: Text(
                                            '${cityList![index].cityName}'),
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
          :Center(
    child: CircularProgressIndicator(
    valueColor:
    AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
    ),
    ),
    );
  }

  void updateListView(int id, String vcityName) async {
    /*--- Get City List Online-----*/
    await getCityList(vcityName).then((value) {
      setState(() {
        this.cityList = value!.cityList!;
        this.count = cityList.length;
      });
    });

  }
}
