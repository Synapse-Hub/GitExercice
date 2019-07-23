import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iomco_project/Design/Lists/provinceList.dart';
import 'package:iomco_project/Model/cls_province.dart';

class ProvinceIns extends StatefulWidget {

  @override
  _ProvinceInsState createState() => _ProvinceInsState();
}

class _ProvinceInsState extends State<ProvinceIns> {
  Province province = new Province();
File _image;
  String adm1pCode;
  String nameP;
  TextEditingController
      cadm1pCode = new TextEditingController(),
      cnameP = new TextEditingController();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff416391),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Provinces",
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
                  context, MaterialPageRoute(builder: (ctx) => MyProvList()));
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
                        'Save Province',
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
                        controller: cnameP,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //             border: new OutlineInputBorder(
                            //      borderRadius: new BorderRadius.circular(20.0)
                            //  ),
                            hintText: 'Nom de la Province'),
                        validator: (val) => val.length == 0
                            ? "Entrer le nom de la Province"
                            : null,
                        onSaved: (val) => this.nameP = val,
                      ),
                    ),
                    // SizedBox(
                    //     height: 16.0,
                    //   ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        controller: cadm1pCode,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            //         border: new OutlineInputBorder(
                            //  borderRadius: new BorderRadius.circular(20.0)
                            //),
                            hintText: 'pCode Province'),
                        validator: (val) => val.length == 0
                            ? "Entrer le pcode"
                            : null,
                        onSaved: (val) => this.adm1pCode = val,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                elevation: 5.0,
                                color: Colors.white,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.blue,
                                ),
                                onPressed:(){},// getImageGallery,
                              ),
                              RaisedButton(
                                elevation: 5.0,
                                color: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                ),
                                onPressed: (){},
                                //getImageCamera,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 120.0,
                            child: Align(
                              alignment: Alignment.center,
                                child: _image == null
                                    ? new Text(
                                        "No image selected!",
                                        textAlign: TextAlign.center,
                                      )
                                    : new Image.file(_image,fit:BoxFit.cover,)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.white,),
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
    var p = Province();
    p.colAdm1Pcode = adm1pCode;
    p.colPname = nameP;
    p.addNewProvince(p);
    innit();
  }
  void innit(){
    cadm1pCode.text="";
    cnameP.text="";
    //adm2pCode="";
    adm1pCode="";
    nameP="";
  }
}
