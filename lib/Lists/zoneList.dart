import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iomco_project/Design/Lists/asList.dart';
import 'package:iomco_project/Design/zsIns.dart';
import 'package:iomco_project/Model/cls_zoneSante.dart';

Future<List<ZoneSante>> getZoneSanteFormDB(String codeTerri) async {
  var as1 = ZoneSante();
  Future<List<ZoneSante>> zoneSantes = as1.getZoneSantes(codeTerri);
  return zoneSantes;
}

class MyzsList extends StatefulWidget {
  final String nomTerritoire, codeTerritoire;

  const MyzsList({Key key, this.nomTerritoire, this.codeTerritoire})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new MyzsListState();
}

class MyzsListState extends State<MyzsList> {
  //create Controller for update name and ...
  final cNamezs = TextEditingController();
  final cCodezs = TextEditingController();
  var x=['zone1','zone2','zone3'];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        backgroundColor: Color(0xff416391),
        title: Text('ZoneSante List'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed: (){
            showSearch(context: context, delegate: DataSearch(x));
          },)
        ],
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
                          builder: (ctx) => ZsInsert(
                                nomTerri: widget.nomTerritoire,
                                codeTerri: widget.codeTerritoire,
                              )));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'New Zone de Santé',
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
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<ZoneSante>>(
          future: getZoneSanteFormDB(widget.codeTerritoire),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucune Zone de Santé trouvée pour ce territoire.\nMerci de créer une nouvelle Zone de Santé!',
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
                                              builder: (ctx) => MyAsList(
                                                    nomZs:
                                                        '${snapshot.data[index].colNamezs}',
                                                    codeZs:
                                                        '${snapshot.data[index].colCodezs}',
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
                                            'Zone de ${snapshot.data[index].colNamezs}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
                                        Text(
                                          'Code ZoneSante: ${snapshot.data[index].colCodezs}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          'Adm2pCode: ${snapshot.data[index].colAdm2pcodez}',
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
                                                                    'Nom ZoneSante',
                                                                hintText:
                                                                    '${snapshot.data[index].colNamezs}'),
                                                            controller: cNamezs,
                                                          ),
                                                          TextFormField(
                                                            autofocus: false,
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    'Code Zone de Sante',
                                                                hintText:
                                                                    '${snapshot.data[index].colCodezs}'),
                                                            controller: cCodezs,
                                                          ),
                                                          // TextFormField(
                                                          //   autofocus: false,
                                                          //   decoration: InputDecoration(
                                                          //       labelText:
                                                          //           'Adm2 pCode zone',
                                                          //       hintText:
                                                          //           '${snapshot.data[index].colAdm2pcodez}'),
                                                          //   controller:
                                                          //       cAdm2pCodez,
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
                                                    ZoneSante as1 =
                                                        new ZoneSante();
                                                    as1.colIdz = snapshot
                                                        .data[index].colIdz;
                                                    //if textfield name is empty, keep the old value
                                                    as1.colNamezs =
                                                        cNamezs.text != ''
                                                            ? cNamezs.text
                                                            : snapshot
                                                                .data[index]
                                                                .colNamezs;

                                                    as1.colCodezs =
                                                        cCodezs.text != ''
                                                            ? cCodezs.text
                                                            : snapshot
                                                                .data[index]
                                                                .colCodezs;
                                                    as1.colAdm2pcodez = snapshot
                                                        .data[index]
                                                        .colAdm2pcodez;

                                                    //update
                                                    as1.updateZoneSante(as1);
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'ZoneSante was updated',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        backgroundColor:
                                                            Colors.white,
                                                        textColor:
                                                            Colors.black);
                                                    setState(() {
                                                      getZoneSanteFormDB(widget
                                                          .codeTerritoire); //refresh data
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
                    'Aucune ZoneSante trouvée.\nMerci de créer une nouvelle Zone de Santé!',
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
//button for synchro
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff416391),
        onPressed: () {},
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

@override
class DataSearch extends SearchDelegate<String>{
  var tab=['Aucun élément'];
  DataSearch(List tableau){
   tab=tableau;
  }
  final recent=["Taper votre requete"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for appBar
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){
      query="";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(icon: AnimatedIcon(icon:AnimatedIcons.menu_arrow,
    progress: transitionAnimation,), 
    onPressed: () {
      close(context, null);
    },);
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searching for something
final suggestionList=query.isEmpty?recent : tab.where((p)=>p.startsWith(query)).toList();
return ListView.builder(itemBuilder: (context,index)=>ListTile(
onTap: (){
  showResults(context);
  
},

leading: Icon(Icons.playlist_add_check),
title: RichText(text: TextSpan(text: suggestionList[index].substring(0,query.length),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
children: [TextSpan(text: suggestionList[index].substring(query.length),style: TextStyle(color: Colors.grey))]
),)
),itemCount: suggestionList.length,);
  }
  
}