

import 'package:flutter/material.dart';

import 'menu_details.dart';

class MenuItems {
  static const List<MenuDetails> menuList= [
    editData,
    addNotes
  ];
  static const editData =MenuDetails(text:"Edit");
  static const addNotes =MenuDetails(text:"Add Notes");


}