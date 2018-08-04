import "package:flutter/material.dart";
import "./products.dart";

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<StatefulWidget> {
  String username = '';
  String password = '';

  _loginContainer() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // username
              TextField(
                  decoration: InputDecoration(labelText: "User Name"),
                  onChanged: (value) {
                    setState(() {
                      this.username = value;
                    });
                  }),

              // password
              TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  onChanged: (value) {
                    setState(() {
                      this.password = value;
                    });
                  }),

              // login button
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  child: Text("Login"),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ),
            ]));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // // app bar
        // appBar: AppBar(
        //   title: Text("Login"),
        // ),

        // body
        body: _loginContainer());
  }
}
