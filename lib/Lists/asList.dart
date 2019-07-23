import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iomco_project/Design/Lists/villageList.dart';
import 'package:iomco_project/Design/asIns.dart';
import 'package:iomco_project/Model/cls_airSante.dart';

Future<List<AirSante>> getASanteFormDB(String codeZone) async {
  var as1 = AirSante();
  Future<List<AirSante>> airSantes = as1.getAirSante(codeZone);
  return airSantes;
}

class MyAsList extends StatefulWidget {
  final String nomZs, codeZs;

  const MyAsList({Key key, this.nomZs, this.codeZs}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new MyAsListState();
}

class MyAsListState extends State<MyAsList> {
  //create Controller for update name and phone
  final cNameas = TextEditingController();
  final cNumeroOrdre = TextEditingController();
  final cCodeas = TextEditingController();
  final cCodezas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Air de Santé",
          style: TextStyle(color: Colors.black),
        ),
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => AsInsert(
                                codeZoneSante: widget.codeZs,
                              )));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'New Air Santé',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.height / 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        child: Icon(
                      Icons.playlist_add,
                      textDirection: TextDirection.ltr,
                      color: Colors.white,
                      size: 44.0,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body:
          // Column(
          //   children: <Widget>[
          //     Text("choose the \'Air de Santé\'",style: TextStyle(color: Colors.blue),),
          //     Divider(),
          //     Text("Zone de Santé de ${widget.nomZs}",style: TextStyle(color: Colors.blue),),
          //     Divider(),
          new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<AirSante>>(
          future: getASanteFormDB(widget.codeZs),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Aucun Air de Santé trouvé pour cette zone.\nMerci de créer un nouvel Air de Santé!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: MediaQuery.of(context).size.height / 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => MyVillageList(
                                                    nomAs:
                                                        '${snapshot.data[index].colNameAs}',
                                                    codeAs:
                                                        '${snapshot.data[index].colCodeAs}',
                                                  )));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            'As de ${snapshot.data[index].colNameAs}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
                                        Text(
                                          'Code AirSante: ${snapshot.data[index].colCodeAs}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        // Text('Code Air de Santé: ${snapshot.data[index].colcodeasv}',

                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
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
                                            contentPadding:
                                                const EdgeInsets.all(16.0),
                                            content: new Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: ListView(
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          TextFormField(
                                                            autofocus: true,
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    'Nom AirSante',
                                                                hintText:
                                                                    '${snapshot.data[index].colNameAs}'),
                                                            controller: cNameas,
                                                          ),
                                                          TextFormField(
                                                            autofocus: false,
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    'Numero d\'ordre',
                                                                hintText:
                                                                    '${snapshot.data[index].colNumordreAs}'),
                                                            controller:
                                                                cNumeroOrdre,
                                                          ),
                                                          // TextFormField(
                                                          //   autofocus: false,
                                                          //   decoration: InputDecoration(
                                                          //     labelText: 'Code AirSante',
                                                          //       hintText:
                                                          //           '${snapshot.data[index].colCodeAs}'),
                                                          //   controller: cCodeas,
                                                          // ),
                                                          // TextFormField(
                                                          //   autofocus: false,
                                                          //   decoration: InputDecoration(
                                                          //     labelText: 'Code zonne de Santé',
                                                          //       hintText:
                                                          //           '${snapshot.data[index].colcodezsa}'),
                                                          //   controller: cCodezas,
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
                                                  initialise();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('CANCEL'),
                                              ),
                                              new FlatButton(
                                                  onPressed: () {
                                                    AirSante as1 =
                                                        new AirSante();
                                                    as1.colIda = snapshot
                                                        .data[index].colIda;
                                                    //if textfield name is empty, keep the old value
                                                    as1.colNameAs =
                                                        cNameas.text != ''
                                                            ? cNameas.text
                                                            : snapshot
                                                                .data[index]
                                                                .colNameAs;
                                                    as1.colNumordreAs =
                                                        cNumeroOrdre.text != ''
                                                            ? cNumeroOrdre.text
                                                            : snapshot
                                                                .data[index]
                                                                .colNumordreAs;

                                                    as1.colCodeAs =
                                                        cNumeroOrdre.text != ''
                                                            ? widget.codeZs +
                                                                cCodeas.text
                                                            : snapshot
                                                                .data[index]
                                                                .colCodeAs;
                                                    as1.colcodezsa = snapshot
                                                        .data[index].colcodezsa;
                                                    //update
                                                    as1.updateAirSante(as1);
                                                    initialise();
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'AirSante was updated',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        backgroundColor:
                                                            Colors.white,
                                                        textColor:
                                                            Colors.black);
                                                    setState(() {
                                                      getASanteFormDB(widget
                                                          .codeZs); //refresh data
                                                    });
                                                  },
                                                  child: Text('UPDATE')),
                                            ],
                                          ));
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Color(0xff416391),
                                ),
                              ),

                              new Divider(),
                            ],
                          ),
                        );
                      });
                }
              } else {
                return Text(
                    'Aucun AirSante trouvé.\nMerci de créer un nouveau AirSante!',
                    style: TextStyle(color: Colors.white));
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
      // ],
      //),
//button for synchro
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff416391),
        onPressed: () {},
        tooltip: 'Synchronisation',
        child: Icon(Icons.sync),
      ),
    );
  }

  void initialise() {
    cNumeroOrdre.text = "";
    cNameas.text = "";
  }

  @override
  void initState() {
    super.initState();
  }
}
