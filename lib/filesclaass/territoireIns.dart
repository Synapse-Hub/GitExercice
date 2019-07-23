import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/territoireList.dart';
import 'package:iomco_project/Model/cls_territoire.dart';

class TerritoireIns extends StatefulWidget {
  final String nomProv,codeProv;

  const TerritoireIns({Key key, this.nomProv, this.codeProv}) : super(key: key);
  @override
  _TerritoireInsState createState() => _TerritoireInsState();
}

class _TerritoireInsState extends State<TerritoireIns> {
  Territoire territoire = new Territoire();

  String adm2pCode;
  //String adm1pCode;
  String namet;
  TextEditingController cAdm2pCode = new TextEditingController(),
      //cadm1pCode = new TextEditingController(),
      cnamet = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Territoires",
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
                  context, MaterialPageRoute(builder: (ctx) => MyTList(nomProv:widget.nomProv,codeProv: widget.codeProv,)));
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
                        'Save Territoire',
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
                        controller: cnamet,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Nom du Territoire'),
                        validator: (val) => val.length == 0
                            ? "Entrer le nom du Territoire"
                            : null,
                        onSaved: (val) => this.namet = val,
                      ),
                    ),
                    // SizedBox(
                    //     height: 16.0,
                    //   ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: TextFormField(
                    //     controller: cadm1pCode,
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         //         border: new OutlineInputBorder(
                    //         //  borderRadius: new BorderRadius.circular(20.0)
                    //         //),
                    //         hintText: 'pCode1 du Territoire'),
                    //     validator: (val) => val.length == 0
                    //         ? "Entrer le pcode1 du Territoire"
                    //         : null,
                    //     onSaved: (val) => this.adm1pCode = val,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cAdm2pCode,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Admin2 pCode Territoire'),
                        validator: (val) => val.length == 0
                            ? "Entrer le pcode2 Territoire"
                            : null,
                        onSaved: (val) => this.adm2pCode = val,
                      ),
                    ),
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
    var t = Territoire();
    t.colAdm2pcode = adm2pCode;
    t.colAdm1pcodet = widget.codeProv;
    t.colTname = namet;
    t.addNewTerritoire(t);
    innit();
  }
  void innit(){
    cAdm2pCode.text="";
    //cadm1pCode.text="";
    cnamet.text="";
    adm2pCode="";
    //adm1pCode="";
    namet="";
  }
}
