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
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  _loginContainer() {
    return Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // username
              TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (value) {
                    setState(() {
                      this._email = value;
                    });
                  }),

              // password
              TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  onChanged: (value) {
                    setState(() {
                      this._password = value;
                    });
                  }),

              // term and condition
              Container(padding: EdgeInsets.only(top: 15.0), child: SwitchListTile(
                value: this._acceptTerms, 
                title: Text("Accept Terms", style: TextStyle(color: Colors.grey)),
                onChanged: (bool value){
                  setState((){
                    this._acceptTerms = value;
                  });
                }
              )),

              // login button
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: RaisedButton(
                  child: Text("Login"),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    print("email: " + this._email);
                    print("password: " + this._password);
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                ),
              ),
            ]));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  }
}
