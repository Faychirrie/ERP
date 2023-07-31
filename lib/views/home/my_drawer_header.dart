
import 'package:flutter/material.dart';
import '../../models/Home/menu_model.dart';
class MyHeaderDrawer extends StatefulWidget {
  final MenuModel menuModel;
  const MyHeaderDrawer ({ Key? key, required this.menuModel }): super(key: key);
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: height*0.25,

      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/pdil_logo.png'),
              ),
            ),
          ),
          Text(
            widget.menuModel.vempName!,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            widget.menuModel.vbusinessAreaName!,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
