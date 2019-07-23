import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/asList.dart';
import 'package:iomco_project/Model/cls_airSante.dart';

class AsInsert extends StatefulWidget {
  final String codeZoneSante,nomZs;

  const AsInsert({Key key, this.codeZoneSante, this.nomZs}) : super(key: key);

  
  @override
  _AsInsertState createState() => _AsInsertState();
}

class _AsInsertState extends State<AsInsert> {
  AirSante airSante = new AirSante();

  //String codeasz;
  String numordreas;
  //String codeas;
  String nameas;
  TextEditingController ccodeasz = new TextEditingController(),
      cnumordreas = new TextEditingController(),
      ccodeas = new TextEditingController(),
      cnameas = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("AirSantes",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'View List',
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => MyAsList(nomZs: widget.nomZs,codeZs: widget.codeZoneSante,)));
            },
          )
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
                  submitAs();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Save AirSante',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.height / 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        child: Icon(
                      Icons.save,
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
      body: ListView(
        children: <Widget>[
          Container(
            color: Color(0xff416391),
            child: Align(
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),

                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cnameas,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Nom de l\'AirSante'),
                        validator: (val) => val.length == 0
                            ? "Entrer le nom de l\' AirSante"
                            : null,
                        onSaved: (val) => this.nameas = val,
                      ),
                    ),
                    // SizedBox(
                    //     height: 16.0,
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cnumordreas,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Numero d\'ordre'),
                        validator: (val) =>
                            val.length == 0 ? "Entrer le num d\'ordre" : null,
                        onSaved: (val) => this.numordreas = val,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: ccodeas,
                    //     focusNode: FocusNode(),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //         border: new OutlineInputBorder(
                    //         //  borderRadius: new BorderRadius.circular(20.0)
                    //         //),
                    //         hintText: 'Code du AirSante'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le code du AirSante"
                    //         : null,
                    //     onSaved: (val) => this.codeas = val,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: ccodeasz,
                    //     focusNode: FocusNode(),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //             border: new OutlineInputBorder(
                    //         //      borderRadius: new BorderRadius.circular(20.0)
                    //         //  ),
                    //         hintText: 'Code zone de Santé'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le code zone de Santé"
                    //         : null,
                    //     onSaved: (val) => this.codeasz = val,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitAs() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    var as1 = AirSante();
    as1.colcodezsa = widget.codeZoneSante;
    as1.colCodeAs = as1.colcodezsa+''+numordreas;
    as1.colNameAs = nameas;
    as1.colNumordreAs = numordreas;
    as1.addNewAirSante(as1,as1.colcodezsa);
    innit();
  }
  void innit(){
    ccodeasz.text="";
    ccodeas.text="";
    cnameas.text="";
    cnumordreas.text="";
    //codeasz="";
    //codeas="";
    nameas="";
    numordreas="";
  }
}
