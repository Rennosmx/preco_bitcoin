import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _precoBitCoin;

  _atualizarPrecoBitCoin() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map<String, dynamic> objetoResultado = json.decode(response.body);    
    setState(() {
      _precoBitCoin = objetoResultado["BRL"]["buy"].toString();
    });
  }

  @override
  void initState() {
    _atualizarPrecoBitCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ " + _precoBitCoin,
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Atualizar"),
                textColor: Colors.white,
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: () {
                  _atualizarPrecoBitCoin();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
