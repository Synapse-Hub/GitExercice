import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:iomco_project/Design/Lists/territoireList.dart';
import 'package:iomco_project/Design/provIns.dart';
import 'package:iomco_project/Model/cls_province.dart';

Future<List<Province>> getProvinceFormDB() async {
  var as1=Province();
  Future<List<Province>> provinces = as1.getProvince();
  return provinces;
}

class MyProvList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new MyProvListState();
}

class MyProvListState extends State<MyProvList> {
  //create Controller for update name and phone
  final cPname = TextEditingController();
  final cAdmin1pCodet = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        backgroundColor: Color(0xff416391),
        title: Text('Province List'),
      ),
      
      bottomNavigationBar: Card(
        
        child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width / 1.0,
                              decoration: BoxDecoration(
                                  color: Color(0xff416391),
                                  borderRadius: BorderRadius.all(Radius.circular(16))),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    //aller à Insertion 
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => ProvinceIns()));
                                                                  },
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Text(
                                                                          'New Province',
                                                                          style: TextStyle(
                                                                              color: Colors.white, fontWeight: FontWeight.normal,fontSize:MediaQuery.of(context).size.height/25 ),textAlign: TextAlign.center,
                                                                        ),
                                                                      ),
                                                                      Expanded(child: Icon(Icons.playlist_add,textDirection: TextDirection.ltr,color: Colors.white,size: 44.0,))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              
                                                            ),
                                                      ),
      ),
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Province>>(
          
          future: getProvinceFormDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text('Aucune Province trouvée.\nMerci de créer une nouvelle Province!',
                                                                          style: TextStyle(
                                                                              color: Colors.white, fontWeight: FontWeight.normal,fontSize:MediaQuery.of(context).size.height/25 ),textAlign: TextAlign.center,
                                                                        ),);
              }else{
                return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(1.0),
                    color: Colors.white,
                    elevation: 2.0,
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => MyTList(
                                                    nomProv:
                                                        '${snapshot.data[index].colPname}',
                                                    codeProv:
                                                        '${snapshot.data[index].colAdm1Pcode}',
                                                  )));
                              },
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Province: ${snapshot.data[index].colPname}',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                  //   style: TextStyle(color: Colors.grey[500]),
                                  // ),
                                  Text('pCode : ${snapshot.data[index].colAdm1Pcode}',
                                    style: TextStyle(color: Colors.red),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            child: Icon(Icons.location_city),
                          ),
                        ),
                        //create update and delete button
                        GestureDetector(
                          onTap: () {
                            //show dialog to enter values
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                      contentPadding: const EdgeInsets.all(16.0),
                                      content: new Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: ListView(
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    TextFormField(
                                                      autofocus: true,
                                                      decoration: InputDecoration(
                                                        labelText: 'Nom Province',
                                                          hintText:
                                                              '${snapshot.data[index].colPname}'),
                                                      controller: cPname,
                                                    ),
                                                    TextFormField(
                                                      autofocus: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Adm1pCode',
                                                          hintText:
                                                              '${snapshot.data[index].colAdm1Pcode}'),
                                                      controller:cAdmin1pCodet,
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('CANCEL'),
                                        ),
                                        new FlatButton(
                                            onPressed: () {
                                              Province as1 = new Province();
                                              as1.colIdp =
                                                  snapshot.data[index].colIdp;
                                              //if textfield name is empty, keep the old value
                                              as1.colPname =
                                                  cPname.text != ''
                                                      ? cPname.text
                                                      : snapshot.data[index].colPname;

                                                          as1.colAdm1Pcode =
                                                  cAdmin1pCodet.text != ''
                                                      ? cAdmin1pCodet.text
                                                      : snapshot.data[index].colAdm1Pcode;

                                              //update
                                              as1.updateProvince(as1);
                                              Navigator.pop(context);
                                              setState(() {
                                                getProvinceFormDB(); //refresh data
                                              });
                                            },
                                            child: Text('UPDATE')),
                                      ],
                                    ));
                          },
                          child: Icon(Icons.edit, color: Color(0xff416391),),
                        ),
                        
                        new Divider(),
                      ],
                    ),
                  );
                });
              }
              } else{
                return Text('Aucune Province trouvée.\nMerci de créer une nouvelle Province!',style: TextStyle(color: Colors.white));
              }
            }

//show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
//button for synchro
floatingActionButton: FloatingActionButton(
  backgroundColor: Color(0xff416391),
        onPressed: (){},
        tooltip: 'Synchronisation',
        child: Icon(Icons.sync),
      ), 


    );
  }

  @override
  void initState() {
    super.initState();
  }
}
