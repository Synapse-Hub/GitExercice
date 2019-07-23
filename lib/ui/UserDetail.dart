import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xoo/models/users.dart';
import 'package:xoo/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xoo/ui/UserList.dart';

class UserDetail extends StatefulWidget{

  final String appBarTitle;
  final Users user;

  UserDetail(this.user, this.appBarTitle);

    @override
    State<StatefulWidget> createState(){
      return UserDetailState(this.user,this.appBarTitle);
    }
  }

  class UserDetailState extends State<UserDetail> {
    
    DatabaseHelper helper=DatabaseHelper();
    String appBarTitle;
    Users user;

    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    UserDetailState(this.user,this.appBarTitle);

    @override
    Widget build(BuildContext context){
      
      TextStyle textStyle  = Theme.of(context).textTheme.title;

      nameController.text = user.name;
      usernameController.text = user.username;
      passwordController.text = user.password;

      return WillPopScope(
        
        onWillPop: (){
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      moveToLastScreen();
                    }
              ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
                children: <Widget>[

                  //First Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextField(
                      controller: nameController,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in name Text Field');
                        updateTitle();
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                        )
                      ),
                    ),
                  ),

                //second Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: usernameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateUserName();
                    },
                    decoration: InputDecoration(
                        labelText: 'UserName',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

              //Third Element
              Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: passwordController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Description Text Field');
							    updatePassword();
						    },
						    decoration: InputDecoration(
								    labelText: 'Password',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),
	    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),


                ],
            ),
            
            ),
          ),
        
        );
    }


    void moveToLastScreen() {
	  	Navigator.pop(context, true);
    }

  // Update the name of User object
  void updateTitle(){
    user.name = nameController.text;
  }

  // Update the username of User object
	void updateUserName() {
		user.username = usernameController.text;
	}

  // Update the password of user object
	void updatePassword() {
		user.password = passwordController.text;
	}

  // Save data to database
	void _save() async {

		moveToLastScreen();

		//user.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (user.id != null) {  // Case 1: Update operation
			result = await helper.updateUser(user);
		} else { // Case 2: Insert Operation
			result = await helper.insertUser(user);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'User Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving user');
		}

	}


  void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (user.id == null) {
			_showAlertDialog('Status', 'No Note was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await helper.deleteUser(user.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Note Deleted Successfully');
		} else {
			_showAlertDialog('Status', 'Error Occured while Deleting Note');
		}
	}

  void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}




}