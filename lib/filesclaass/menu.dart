
import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/asList.dart';
import 'package:iomco_project/Design/Lists/territoireList.dart';
import 'package:iomco_project/Design/Lists/villageList.dart';
import 'package:iomco_project/Design/Lists/zoneList.dart';

class MyMenu extends StatefulWidget {
  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
Widget buildGrid(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: (MediaQuery.of(context).size.width - 60 / 3) / 300,
      children: <Widget>[
        buildTile(context, 0, "VILLAGE", null, Icons.domain, "O items",
            Colors.orange, Colors.orange[50]),
        buildTile(context, 1, "AIR DE SANTE", null, Icons.healing, "O items",
            Colors.blue, Colors.blue[50]),
        buildTile(context, 2, "ZONE SANTE", null, Icons.healing, "0 items",
            Colors.purple, Colors.purple[50]),
        buildTile(context, 3, "TERRITOIRE", null, Icons.crop_original, "0 items",
            Colors.red, Colors.red[50]),
        buildTile(context, 5, "PROVINCE", null, Icons.location_city, "0 items",
            Colors.red, Colors.red[50]),
      ],
    );
  }

  int _selectedIndex = -1;

  Widget buildTile(BuildContext context, int index, String heading, Image image,
      IconData icon, String itemCount, Color color, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.only(
          left: index == 0 || index == 2 || index == 4 ? 8 : 4,
          top: 0,
          right: index == 1 || index == 3 || index == 5 ? 8 : 4,
          bottom: 4),
      decoration: BoxDecoration(
          color: Color(0xff416391), borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyVillageList()));
            }
            else if (_selectedIndex == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyAsList()));
            }
            else if (_selectedIndex == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyzsList()));
            }
            else if (_selectedIndex == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyTList()));
            }
          });
          print("tapped");
        },
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: _selectedIndex == index && color != null
                        ? color
                        : Colors.white),
                borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    index == 4
                        ? IconButton(
                            icon: image,
                            onPressed: () {},
                          )
                        : Icon(
                            icon,
                            color: color,
                            size: 30.0,
                          ),
                    index != 1
                        ? SizedBox(
                            height: 2,
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ],
                ),
                Text(
                  heading,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  itemCount,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                )
              ],
            ))),
      ),
//      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Menu",style: TextStyle(color: Colors.black),),
        ),
      body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      child: buildGrid(context),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue[600],
                                Colors.blue[500],
                                Colors.blue,
                                Colors.blue[400],
                                Colors.blue[300]
                              ])),
                      margin: EdgeInsets.only(left: 12, right: 12),
                    )
                  ],
                )
              ],
            )
          ],
        ),
    );
  }
}