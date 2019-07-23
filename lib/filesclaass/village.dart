import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/villageList.dart';
import 'package:iomco_project/Model/cls_village.dart';

class VillageIns extends StatefulWidget {
  final String myCodeAs,myNomAs;

  const VillageIns({Key key, this.myCodeAs, this.myNomAs}) : super(key: key);

  @override
  _VillageInsState createState() => _VillageInsState();
}

class _VillageInsState extends State<VillageIns> {
  Village village = new Village();

  String codeasv;
  String numordrevlg;
  String codevlg;
  String namevlg;
  TextEditingController 
      cnumordrevlg = new TextEditingController(),
      cnamevlg = new TextEditingController();
void innitV(){
  codeasv="";
  numordrevlg="";
  codevlg="";
  namevlg="";
  cnamevlg.text="";
  cnumordrevlg.text="";
}

  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Villages",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'View List',
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (ctx) => MyVillageList(nomAs: widget.myNomAs,codeAs: widget.myCodeAs,)));
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
                  submitVillage();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Save Village',
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
                        controller: cnamevlg,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Nom du village'),
                        validator: (val) =>
                            val.length == 0 ? "Entrer le nom du village" : null,
                        onSaved: (val) => this.namevlg = val,
                      ),
                    ),
                    // SizedBox(
                    //     height: 16.0,
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cnumordrevlg,
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
                        onSaved: (val) => this.numordrevlg = val,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: ccodevlg,
                    //     focusNode: FocusNode(),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //         border: new OutlineInputBorder(
                    //         //  borderRadius: new BorderRadius.circular(20.0)
                    //         //),
                    //         hintText: 'Code du Village'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le code du village"
                    //         : null,
                    //     onSaved: (val) => this.codevlg = val,
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: ccodeasv,
                    //     focusNode: FocusNode(),
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //             border: new OutlineInputBorder(
                    //         //      borderRadius: new BorderRadius.circular(20.0)
                    //         //  ),
                    //         hintText: 'Code Air de sante'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le code Air de Sante"
                    //         : null,
                    //     onSaved: (val) => this.codeasv = val,
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

  void submitVillage() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    var vlg = Village();
    vlg.colcodeasv = widget.myCodeAs;
    vlg.colCodevlg = widget.myCodeAs+numordrevlg;
    vlg.colNamevlg = namevlg;
    vlg.colNumordrevlg = numordrevlg;
    vlg.addNewVillage(vlg);
    innitV();
  }
}
