
import 'package:flutter/material.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../models/crm/enquiry_source_model.dart';
import '../../models/common/int_select_data.dart';
import '../home/home_page.dart';

class SourceListPage extends StatefulWidget {
  SourceListPage({Key? key, required this.title, required this.select})
      : super(key: key);
  final String title;
  final bool select;
  @override
  _SourceListPageState createState() => _SourceListPageState();
}

class _SourceListPageState extends State<SourceListPage> {
  List<SourceList> sourceList = [];
  int count = 0;
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (sourceList.isEmpty) {
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
      body:this.sourceList!.length>0? SafeArea(
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: this.sourceList.length > 0
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
                                        int ilead_source = 0;
                                        String venquiry_source = "";
                                        if (sourceList![index].id !>0) {
                                          ilead_source =
                                          sourceList![index].id!;
                                          venquiry_source =
                                          sourceList![index]
                                              .venquirySource!;
                                        }
                                        if (widget.select) {
                                          Navigator.of(context).pop(
                                              IntSelectData(ilead_source,
                                                  venquiry_source,""));
                                        }
                                      },
                                      child: ListTile(

                                        title: Text(
                                            '${sourceList![index].venquirySource}'),
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

  void updateListView(int id, String venquirySource) async {
    /*--- Get Source List Online-----*/
    await getEnquirySourceList(venquirySource).then((value) {
      setState(() {
        this.sourceList = value!.sourceList!;
        this.count = sourceList.length;
      });
    });

  }
}
