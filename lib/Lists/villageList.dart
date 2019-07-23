import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iomco_project/Design/village.dart';
import 'package:iomco_project/Model/cls_village.dart';

Future<List<Village>> getVillageFormDB(String codeAs) async {
  var vlg1=Village();
  Future<List<Village>> villages = vlg1.getVillages(codeAs);
  return villages;
}

class MyVillageList extends StatefulWidget {
  final String nomAs,codeAs;

  const MyVillageList({Key key, this.nomAs, this.codeAs}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new MyVillageListState();
}

class MyVillageListState extends State<MyVillageList> {
  //create Controller for update name and phone
  final cNameVlg = TextEditingController();
  final cNumeroOrdre = TextEditingController();
  final cCodeVlg = TextEditingController();
  final cCodeAs = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        backgroundColor: Color(0xff416391),
        title: Text('Village List'),
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
                                    //aller à Insertion village
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => VillageIns(myCodeAs: widget.codeAs,myNomAs: widget.nomAs,)));
                                                                  },
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Text(
                                                                          'Nouveau village',
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
        child: FutureBuilder<List<Village>>(
          
          future: getVillageFormDB(widget.codeAs),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if(snapshot.hasData) {
            if (snapshot.data.length == 0) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text('Aucun village trouvé pour cet aire de santé.\nMerci de créer un nouveau village!',
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
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Village de ${snapshot.data[index].colNamevlg}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                //   style: TextStyle(color: Colors.grey[500]),
                                // ),
                                Text('Code du Village: ${snapshot.data[index].colCodevlg}',
                                  style: TextStyle(color: Colors.red),
                                ),
                                // Text('Code Air de Santé: ${snapshot.data[index].colcodeasv}',
                                  
                                //   style: TextStyle(color: Colors.grey[500]),
                                // ),

                              ],
                            ),
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
                                                        labelText: 'Nom du Village',
                                                          hintText:
                                                              '${snapshot.data[index].colNamevlg}'),
                                                      controller: cNameVlg,
                                                    ),
                                                    TextFormField(
                                                      autofocus: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Numero d\'ordre',
                                                          hintText:
                                                              '${snapshot.data[index].colNumordrevlg}'),
                                                      controller: cNumeroOrdre,
                                                    ),
                                                    // TextFormField(
                                                    //   autofocus: false,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: 'Code Village',
                                                    //       hintText:
                                                    //           '${snapshot.data[index].colCodevlg}'),
                                                    //   controller: cCodeVlg,
                                                    // ),

                                                    // TextFormField(
                                                    //   autofocus: false,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: 'Code Air de Santé',
                                                    //       hintText:
                                                    //           '${snapshot.data[index].colcodeasv}'),
                                                    //   controller: cCodeAs,
                                                    // )
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
                                              Village vlg = new Village();
                                              vlg.colIdv =
                                                  snapshot.data[index].colIdv;
                                              //if textfield name is empty, keep the old value
                                              vlg.colNamevlg =
                                                  cNameVlg.text != ''
                                                      ? cNameVlg.text
                                                      : snapshot.data[index].colNamevlg;
                                              vlg.colNumordrevlg =
                                                  cNumeroOrdre.text != ''
                                                      ? cNumeroOrdre.text
                                                      : snapshot
                                                          .data[index].colNumordrevlg;

                                                          vlg.colCodevlg =snapshot.data[index].colCodevlg;
                                              vlg.colcodeasv =
                                                  cNumeroOrdre.text != ''
                                                      ? widget.codeAs+cNumeroOrdre.text
                                                      : snapshot
                                                          .data[index].colcodeasv;

                                              //update
                                              vlg.updateVillage(vlg);
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg: 'Village was updated',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.black);
                                              setState(() {
                                                getVillageFormDB(widget.codeAs); //refresh data
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
              }else {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text('Aucun village trouvé.\nMerci de créer un nouveau village!',style: TextStyle(color: Colors.white),));
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
