import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class indPage extends StatefulWidget {
  @override
  _indPageState createState() => _indPageState();
}

class _indPageState extends State<indPage> {
  var api = "https://api.covid19india.org/data.json";
  var res, statewise;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    res = await http.get(api);
    statewise = jsonDecode(res.body)["statewise"];
    print(statewise.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("India Status"),
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text('State',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),),
                        width: 110.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:4.0),
                      child: Text('CNF',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,color: Colors.red[800]
                      ),),
                      width: 68.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left:4.0),
                      child: Text('ACTV',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,color: Colors.blue[800]
                      ),),
                      width: 68.0,
                    ),
                    Container(
                      child: Text('RCVR',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,color: Colors.green[800],
                      ),),
                      width: 68.0,
                    ),
                    Container(
                      child: Text('DCSD',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,color: Colors.black87
                      ),),
                      width: 68.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: res != null
                      ? ListView.builder(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: statewise.length-1,
                    itemBuilder: (context, index) {
                      var state = statewise[index+1];
                      return Card(
                        elevation: 10.0,
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.all(4.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 110.0,
                                child: Text("${state["state"]}",
                                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsets.all(4.0),
                              ),
                              Container(
                                width: 68.0,
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        child:Text("${state["confirmed"]}",style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red[600],
                                        ),),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 3.0),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.red,
                                            size: 15.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${state["deltaconfirmed"]}",style:TextStyle(
                                            color: Colors.red,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 68.0,
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child:Text("${state["active"]}",style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blue[600],
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 68.0,
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child:Text("${state["recovered"]}",style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green[600],
                                      ),),
                                    ),
                                    Container(
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green[600],
                                            size: 15.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${state["deltarecovered"]}",style:TextStyle(
                                            color: Colors.green[600],
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 68.0,
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child:Text("${state["deaths"]}",style:TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                      ),),
                                    ),
                                    Container(
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Colors.black87,
                                            size: 15.0,
                                            semanticLabel: 'Text to announce in accessibility modes',
                                          ),
                                          Text("${state["deltadeaths"]}",style:TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700,
                                          ),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : CircularProgressIndicator(backgroundColor: Colors.black),
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}