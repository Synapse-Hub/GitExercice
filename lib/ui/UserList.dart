import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xoo/models/users.dart';
import 'package:xoo/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xoo/ui/UserDetail.dart';

class UsersList extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return UserlistState();
  }
}

class UserlistState extends State<UsersList> {

    DatabaseHelper databasehelper = DatabaseHelper();
    List<Users> userList;
    int count =0;

    @override
    Widget build(BuildContext context){

      if(userList == null){
        userList = List<Users>();
        updateListView(); //this method will allow to clean and restart the listview
      }

      return Scaffold(
        appBar: AppBar(title: Text('Xoo App'),),
        body: getUsersListView(),

        //create a floating bouton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('FAB clicked');
            navigateToDetail(Users('','',''), 'Add User');
          },

          tooltip: 'Add user',
          child: Icon(Icons.add),
          
          ),  
      );
    }

    ListView getUsersListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						title: Text(this.userList[position].name, style: titleStyle,),

						subtitle: Text(this.userList[position].username),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, userList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.userList[position],'Edit User');
						},

					),
				);
			},
		);
  }

  void _delete(BuildContext context, Users user) async {

		int result = await databasehelper.deleteUser(user.id);
		if (result != 0) {
			_showSnackBar(context, 'User Deleted Successfully');
			updateListView();
		}
	}

  void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Users user, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return UserDetail(user, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

void updateListView() {

		final Future<Database> dbFuture = databasehelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Users>> noteListFuture = databasehelper.getUsersList();
			noteListFuture.then((noteList) {
				setState(() {
				  this.userList = userList;
				  this.count = userList.length;
				});
			});
		});
  }


}

