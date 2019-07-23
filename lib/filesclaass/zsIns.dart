import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/zoneList.dart';
import 'package:iomco_project/Model/cls_ZoneSante.dart';

class ZsInsert extends StatefulWidget {
  final String nomTerri,codeTerri;

  const ZsInsert({Key key, this.nomTerri, this.codeTerri}) : super(key: key);
  @override
  _ZsInsertState createState() => _ZsInsertState();
}

class _ZsInsertState extends State<ZsInsert> {
  ZoneSante zoneSante = new ZoneSante();

  String adm2pCode;
  String codezs;
  String namezs;
  TextEditingController cAdm2pCode = new TextEditingController(),
      ccodezs = new TextEditingController(),
      cnamezs = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("ZoneSantes",
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
                  context, MaterialPageRoute(builder: (ctx) => MyzsList(nomTerritoire: widget.nomTerri,codeTerritoire: widget.codeTerri,)));
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
                        'Save ZoneSante',
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
                        controller: cnamezs,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Nom de la ZoneSante'),
                        validator: (val) => val.length == 0
                            ? "Entrer le nom de la ZoneSante"
                            : null,
                        onSaved: (val) => this.namezs = val,
                      ),
                    ),
                    // SizedBox(
                    //     height: 16.0,
                    //   ),

                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: ccodezs,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //         border: new OutlineInputBorder(
                            //  borderRadius: new BorderRadius.circular(20.0)
                            //),
                            hintText: 'Code de la ZoneSante'),
                        validator: (val) => val.length == 0
                            ? "Entrer le code de la ZoneSante"
                            : null,
                        onSaved: (val) => this.codezs = val,
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: cAdm2pCode,
                    //     focusNode: FocusNode(),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //             border: new OutlineInputBorder(
                    //         //      borderRadius: new BorderRadius.circular(20.0)
                    //         //  ),
                    //         hintText: 'Admin2 pCode zone de Santé'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le pcode zone de Santé"
                    //         : null,
                    //     onSaved: (val) => this.adm2pCode = val,
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
    var zs1 = ZoneSante();
    zs1.colAdm2pcodez = widget.codeTerri;
    zs1.colCodezs = codezs;
    zs1.colNamezs = namezs;
    zs1.addNewZoneSante(zs1);
    innit();
  }
  void innit(){
    cAdm2pCode.text="";
    ccodezs.text="";
    cnamezs.text="";
    adm2pCode="";
    codezs="";
    namezs="";
  }
}
