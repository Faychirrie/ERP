

import 'package:flutter/material.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/common/string_select_data.dart';
import '../../models/crm/lead_qualification_master_model.dart';
import '../home/home_page.dart';

class LeadQualificationListPage extends StatefulWidget {
  LeadQualificationListPage({Key? key, required this.title, required this.select})
      : super(key: key);
  final String title;
  final bool select;
  @override
  _LeadQualificationListPageState createState() => _LeadQualificationListPageState();
}

class _LeadQualificationListPageState extends State<LeadQualificationListPage> {
  List<QualificationList> qualificationList = [];
  int count = 0;
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (qualificationList.isEmpty) {
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
      body:this.qualificationList.length>0? SafeArea(
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: this.qualificationList.length > 0
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
                                        String clead_qualification = "";
                                        String vqualification = "";
                                        if (qualificationList![index].clead_qualification !="") {
                                          clead_qualification =
                                          qualificationList![index].clead_qualification!;
                                          vqualification ="${qualificationList![index].vqualification!}";
                                        }
                                        if (widget.select) {
                                          Navigator.of(context).pop(
                                              StringSelectData(clead_qualification,
                                                  vqualification));
                                        }
                                      },
                                      child: ListTile(

                                        title: Text(
                                            '${qualificationList![index].vqualification!}'),
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
      ):Center(
    child: CircularProgressIndicator(
    valueColor:
    AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
    ),
    ),
    );
  }

  void updateListView(int id, String vqualificationName) async {
    /*--- Get City List Online-----*/
    await getLeadQualiFicationList(vqualificationName).then((value) {
      setState(() {
        this.qualificationList = value!.qualificationList!;
        this.count = qualificationList.length;
      });
    });

  }
}
