import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iomco_project/Design/Lists/zoneList.dart';
import 'package:iomco_project/Design/territoireIns.dart';
import 'package:iomco_project/Model/cls_territoire.dart';

Future<List<Territoire>> getTerritoireFormDB(String nomPro) async {
  var as1=Territoire();
  Future<List<Territoire>> territoires = as1.getTerritoire(nomPro);
  return territoires;
}

class MyTList extends StatefulWidget {
  final String nomProv,codeProv;

  const MyTList({Key key, this.nomProv, this.codeProv}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new MyTListState();
}

class MyTListState extends State<MyTList> {
  //create Controller for update name and phone
  final cNamet = TextEditingController();
  final cAdmin1pCodet = TextEditingController();
  final cAdm2pCodet = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        backgroundColor: Color(0xff416391),
        title: Text('Territoire List'),
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
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => TerritoireIns(nomProv: widget.nomProv,codeProv: widget.codeProv)));
                                                                  },
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Text(
                                                                          'New Territoire',
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
        child: FutureBuilder<List<Territoire>>(
          
          future: getTerritoireFormDB(widget.codeProv),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text('Aucun Territoire trouvé pour cette province.\nMerci de créer un nouveau Territoire!',
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
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => MyzsList(
                                                    nomTerritoire:
                                                        '${snapshot.data[index].colTname}',
                                                    codeTerritoire:
                                                        '${snapshot.data[index].colAdm2pcode}',
                                                  )));
                              },
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'Territoire de ${snapshot.data[index].colTname}',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                  //   style: TextStyle(color: Colors.grey[500]),
                                  // ),
                                  Text('pCode Province: ${snapshot.data[index].colAdm1pcodet}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text('pCode Territoire: ${snapshot.data[index].colAdm2pcode}',
                                    
                                    style: TextStyle(color: Colors.red),
                                  ),

                                ],
                              ),
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
                                                        labelText: 'Nom Territoire',
                                                          hintText:
                                                              '${snapshot.data[index].colTname}'),
                                                      controller: cNamet,
                                                    ),
                                                    // TextFormField(
                                                    //   autofocus: false,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: 'Adm1pCode',
                                                    //       hintText:
                                                    //           '${snapshot.data[index].colAdm1pcodet}'),
                                                    //   controller:cAdmin1pCodet,
                                                    // ),
                                                    TextFormField(
                                                      autofocus: false,
                                                      decoration: InputDecoration(
                                                        labelText: 'Adm2pCode',
                                                          hintText:
                                                              '${snapshot.data[index].colAdm2pcode}'),
                                                      controller: cAdm2pCodet,
                                                    )
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
                                              Territoire as1 = new Territoire();
                                              as1.colIdt =
                                                  snapshot.data[index].colIdt;
                                              //if textfield name is empty, keep the old value
                                              as1.colTname =
                                                  cNamet.text != ''
                                                      ? cNamet.text
                                                      : snapshot.data[index].colTname;

                                                          as1.colAdm1pcodet =snapshot.data[index].colAdm1pcodet;
                                              as1.colAdm2pcode =
                                                  cAdm2pCodet.text != ''
                                                      ? cAdm2pCodet.text
                                                      : snapshot
                                                          .data[index].colAdm2pcode;

                                              //update
                                              as1.updateTerritoire(as1);
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg: 'Territoire was updated',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.black);
                                              setState(() {
                                                getTerritoireFormDB(widget.codeProv); //refresh data
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
                return Text('Aucun Territoire trouvé pour cette province.\nMerci de créer un nouveau Territoire!',style: TextStyle(color: Colors.white));
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
