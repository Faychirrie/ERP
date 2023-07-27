import 'dart:convert';
import 'dart:core';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:sqflite/sqflite.dart';
import '../../controllers/offline_crud_operations/database_helper.dart';
import '../../controllers/offline_crud_operations/url_crud.dart';
import '../../controllers/online_crud_operations/crm_online_crud.dart';
import '../../controllers/online_crud_operations/user_management_online_crud.dart';
import '../../models/Home/menu_model.dart';
import '../../models/common/url_data_model.dart';
import '../crm_manager/url_creation.dart';
import '../home/home_page.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  MenuModel? _menuModel;
  TextEditingController user_name = TextEditingController();
  TextEditingController password = TextEditingController();
  List<dynamic> businessAreaList = [];
  List<dynamic> finYearList = [];
  String? ibusiness_area_id;
  String? ifin_year_id;
  DatabaseHelper databaseHelper = DatabaseHelper();
  URLCrud urlCRUD = URLCrud();
  List<URLDataModel>? urlList;
  String url = "";
  int? count;
  int? check;
 checkLogin()
  async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var vempCode =  sharedPreferences.get("vempCode");
    if(vempCode!=null)
      {
        print("vempcode===================================================");
        print(vempCode);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage(title: "CRM")));
      }else{
      check=0;
    }
  }
  @override
  void initState() {
    checkLogin();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }

    });
    getURLDetail();
    super.initState();
    this
        .businessAreaList
        .add({"id": 1, "label": "Purple Dot International LTD."});
    this.businessAreaList.add({"id": 2, "label": "Anand Industrial Park LTD."});
    this.businessAreaList.add({"id": 3, "label": "Elina Development LTD."});
    this.finYearList.add({"id": 1, "label": "2021"});
    this.finYearList.add({"id": 2, "label": "2022"});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new WillPopScope(
      onWillPop: ()async{
        return false;
      } ,
      child:  Scaffold(
        backgroundColor: Colors.white70,
        body: count == 0 && check==0
            ? Container(
          height: height,
          child: url.isEmpty && count != null
              ? Container(
            child: UrlCreationPage(
              title: 'Settings',
            ),
          )
              : Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .4),
                    SizedBox(
                      height: height * 0.001,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: height * 0.08,
                      child: TextFormField(
                          controller: user_name,
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: "User Name",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true)),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: height * 0.08,
                      child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "password",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true)),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // image: const DecorationImage(
                        //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                        //   fit: BoxFit.cover,
                        // ),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.white,
                      child: FormHelper.dropDownWidget(
                          context,
                          "Select Division",
                          this.ibusiness_area_id,
                          this.businessAreaList, (onchangeVal) {
                        this.ibusiness_area_id = onchangeVal;
                      }, (onValidate) {
                        if (onValidate == null) {
                          return "please select Division";
                        }

                        return null;
                      },
                          optionLabel: "label",
                          optionValue: "id",
                          borderColor: Colors.white,
                          borderRadius: 10),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: height * 0.08,
                      child: FormHelper.dropDownWidget(
                        context,
                        "Financial Year",
                        this.ifin_year_id,
                        this.finYearList,
                            (onchangeVal) {
                          this.ifin_year_id = onchangeVal;
                        },
                            (onValidate) {
                          if (onValidate == null) {
                            return "please select Financial Year";
                          }
                          return null;
                        },
                        optionLabel: "label",
                        optionValue: "id",
                        borderColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.021,
                    ),
                    InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              0.5,
                          padding:
                          EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffaa00ff),
                                    Color(0xff880e4f)
                                  ])),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                        Color(0xff880e4f)),
                                  ),
                                );
                              });
                          String name = user_name.text;
                          String pwd = password.text;
                          MenuModel? data = await login(name, pwd);
                          final SharedPreferences
                          sharedPreferences =
                          await SharedPreferences.getInstance();
                          print("login $data");
                          if (data != null && data.id! > 0) {
                            print(data.vbusinessAreaName);
                            String menuData = jsonEncode(data);
                            sharedPreferences.setString(
                                'menuData', menuData);
                            sharedPreferences.setString(
                                "business_area",
                                data.vbusinessAreaName!);
                            sharedPreferences.setString(
                                "name", data.vempName!);
                            sharedPreferences.setString(
                                "vempCode", data.vempCode!);
                            sharedPreferences.setString(
                                "name", data.vempName!);
                            sharedPreferences.setString(
                                "name", data.vempName!);
                            sharedPreferences.setString(
                                "authToken", data.authToken!);
                            int? id= await getFireBaseToken(data.vempCode!);
                            await addFirebaseToken(id!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(title: "CRM")));
                          }
                          setState(() {
                            _menuModel = data;
                          });
                          // print(status);
                          // if (status != null && status == 200) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               HomePage(
                          //                 title: "CRM",
                          //               )));
                          // }
                          // if(data!=null && data.id>0)
                          // {
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => HomePage(
                          //             title: "CRM",
                          //           )));
                          // }
                          //   },
                        }),
                    SizedBox(
                      height: height * 0.021,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .1,
              right: MediaQuery.of(context).size.width * .1,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child:
                  Image.asset('assets/images/pdil_logo.png')),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .85,
              right: MediaQuery.of(context).size.width * .1,
              top: MediaQuery.of(context).size.height * .05,
              child: GestureDetector(
                  child: Icon(Icons.settings),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UrlCreationPage(
                                  title: "Settings")));
                    });
                  }),
            )
          ]),
        )
            : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff880e4f)),
            ))),);

  }

  Future<String?> getURLDetail() async {
/*--- Get URL List Offline-----*/
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? vurl;
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    await dbFuture.then((database) {
      Future<List<URLDataModel>> urlListFuture = urlCRUD.getUrlList();
      urlListFuture.then((urlListFuture) {
        setState(() {
          this.urlList = urlListFuture;
          if (urlListFuture.length > 0) {
            this.url = urlListFuture[0].vurl;
            // sharedPreferences.setString('url', this.url);
          }
          this.count = 0;
        });
      });
    });
    return vurl;
  }
}
