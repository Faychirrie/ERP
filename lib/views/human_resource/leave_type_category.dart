import 'package:flutter/material.dart';
import '../../controllers/online_crud_operations/human_resource_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/human_resource/leave_type_category_model.dart';
import '../home/home_page.dart';

class LeaveTypeCategoryPage extends StatefulWidget {
  LeaveTypeCategoryPage(
      {Key? key,
        required this.title,
        required this.select,
        required this.units})
      : super(key: key);
  final String title;
  final bool select;
  final bool units;
  @override
  _LeaveTypeCategoryPageState createState() => _LeaveTypeCategoryPageState();
}

class _LeaveTypeCategoryPageState extends State<LeaveTypeCategoryPage> {
  List<LeaveCategoryList>? leaveCategoryList = [];
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
      body: this.leaveCategoryList!.length > 0
          ? SafeArea(
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: this.leaveCategoryList!.length > 0
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
                                        int ileaveType = 0;
                                        String vleaveCategoryName = "";
                                        if (leaveCategoryList![index].id! >
                                            0) {
                                          ileaveType =
                                          leaveCategoryList![index]
                                              .id!;
                                          vleaveCategoryName =
                                          leaveCategoryList![index].vleaveCategoryName!;
                                        }
                                        if (widget.select) {
                                          Navigator.of(context).pop(
                                              IntSelectData(ileaveType,
                                                  vleaveCategoryName, ""));
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                            '${leaveCategoryList![index].vleaveCategoryName}'),
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

  void updateListView(int id, String vleaveCategoryName) async {
    /*--- Get Agent List Online-----*/
    await getLeaveCategoryTypeList(vleaveCategoryName).then((value) {
      setState(() {
        this.leaveCategoryList = value!.leaveCategoryList!;
        this.count = leaveCategoryList!.length;
      });
    });
  }
}
