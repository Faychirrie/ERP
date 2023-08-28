import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/online_crud_operations/property_online_crud.dart';
import '../../models/common/int_select_data.dart';
import '../../models/crm/investor_detail_model.dart';
import '../../models/property/property_units_model.dart';
import '../home/home_page.dart';

class UnitsPerInvestorPage extends StatefulWidget {
  UnitsPerInvestorPage(
      {Key? key,
        required this.title,
        required this.select,
        required this.vcustomerCode,
        required this.ipropertyId})
      : super(key: key);
  final String title;
  final bool select;
  final String vcustomerCode;
  final int ipropertyId;
  @override
  _UnitsPerInvestorPageState createState() => _UnitsPerInvestorPageState();
}

class _UnitsPerInvestorPageState extends State<UnitsPerInvestorPage> {
  List<InvestorList>? unitList = [];
  int? count;
  bool _search = false;

  @override
  void initState() {
    updateListView(widget.ipropertyId, widget.vcustomerCode);

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
                  Navigator.pop(context);
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
                              String dealAmount =  unitList![index].mdealAmount.toString()!;
                              double status = double.parse(dealAmount);
                              NumberFormat numberFormat = NumberFormat('#,##0');
                              String formattedNumber = numberFormat.format(status);
                              Color textColor = Colors.red;
                              return Column(
                                children: [
                                  Material(
                                      elevation: 30.0,
                                      shadowColor: Colors.purple,
                                      child: GestureDetector(
                                        child: ListTile(
                                            leading: Icon(
                                              Icons.home,
                                              color:  Colors.red
                                            ),
                                            title: Text(
                                                '${unitList![index].vsetupName} ${unitList?[0].vfloorName ?? ""} -${unitList![index].vpropertyName}' ),
                                            subtitle:Text(
                                              'Amt: $formattedNumber',
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

  void updateListView(int id, String vcustomerCode) async {
    /*--- Get Agent List Online-----*/
    await getUnitsPerInvestorList(id, vcustomerCode).then((value) {
      setState(() {
        this.unitList = value!.investorList!;
        this.count = unitList!.length;
      });
      print("count");
      print(count);
    });
  }
}
