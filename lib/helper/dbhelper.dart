import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xoo/models/users.dart';
import 'package:xoo/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xoo/ui/UserList.dart';

class dbHelper extends StatefulWidget{

  final String appBarTitle;
  final Users user;

  dbHelper(this.user, this.appBarTitle);

    @override
    State<StatefulWidget> createState(){
      return dbHelperState(this.user,this.appBarTitle);
    }
  }

  
	




}