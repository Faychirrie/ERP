
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/url_crud.dart';
import '../../models/common/url_data_model.dart';
import '../../utils/firebase_api.dart';
import '../user_management/user_login.dart';

class UrlCreationPage extends StatefulWidget {
  UrlCreationPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _UrlCreationPageState createState() => _UrlCreationPageState();
}

class _UrlCreationPageState extends State<UrlCreationPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  URLCrud urlCRUD = URLCrud();
  URLCrud helper = URLCrud();
  List<URLDataModel>? urlList;
  int count = 0;
  URLDataModel urlDetail = new URLDataModel(null, "");
  String header = "";
  TextEditingController vurlController = TextEditingController();
  @override
  void initState() {
    getURLDetail();
    super.initState();
  }

  bool status = true;

  void _save() async {
    urlDetail.vurl = vurlController.text.trim();
    int result = 0;
    if (urlDetail.id != null) {
      // Case 1: Update operation
      result = await helper.updateURL(urlDetail);
      print("update========================1");
    } else {
      // Case 2: Insert Operation
      print("saving========================1");
      result = await helper.insertURl(urlDetail);
    }

    if (result > 0) {
      print('Note Saved Successfully'); // Success
      vurlController.text = "";
      getURLDetail();
      // moveToLastScreen();
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      print('Problem Saving Note');
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (urlList == null) {
      getURLDetail();
    }
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.purple,
            actions: [
              Transform.scale(
                scale: 1.5,
                child: status
                    ? IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _save();
                        },
                        // onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage(title: "CRM")))
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () async{
                          await FirebaseApi().initURLDetails("");
                          moveToLogin();
                        },
                        // onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomePage(title: "CRM")))
                      ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(children: [
              SizedBox(
                height: height * 0.021,
              ),
              // Image(image: AssetImage('assets/pdil_logo.jpg')),
              TextField(
                controller: vurlController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: (Colors.purple[100])!,
                    ),
                  ),
                  hintText: 'Enter URL',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (BuildContext context, int position) {
                              return Card(
                                color: Colors.white,
                                elevation: 2.0,
                                child: ListTile(
                                  title: Text(this.urlList![position].vurl!),
                                  trailing: GestureDetector(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        vurlController.text = urlList![0].vurl;
                                        urlDetail.id = urlList![0].id;
                                        status = true;
                                      });
                                      // _delete(context, ReminderListPage[position]);
                                    },
                                  ),
                                  onTap: () {
                                    debugPrint("ListTile Tapped");
                                    // navigateToDetail(this.ReminderListPage[position],'Edit Note');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.001,
                      ),
                    ],
                  ),
                ),
              ),
              // // color: Colors.white,
            ]),
            // ),
          )),
    );
  }

  void moveToLogin() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserLogin(
                  title: header,
                )));
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // showDialog(
    //     context: context,
    //     builder: (_) => alertDialog
    // );
  }

  void getURLDetail() async {
/*--- Get URL List Offline-----*/
    print("getting List====");
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<URLDataModel>> urlListFuture = urlCRUD.getUrlList();
      urlListFuture.then((urlListFuture) {
        setState(() {
          this.urlList = urlListFuture;
          this.count = urlListFuture.length;
          print("getting List Size====$count");
          if (this.count > 0) {
            status = false;
          }
        });
      });
    });
  }
}
