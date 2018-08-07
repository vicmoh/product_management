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

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'));
  } //end back img

  Widget _buildTextField(String label, dynamic valueToBeSet, bool isObscure) {
    return TextField(
        obscureText: isObscure,
        decoration: InputDecoration(
            labelText: label, filled: true, fillColor: Colors.white),
        onChanged: (value) {
          setState(() {
            valueToBeSet = value;
          });
        });
  }

  Widget _loginContainer() {
    return Container(
        // imaage bakcground
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(15.0),

        // the login container
        child: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          // username
          _buildTextField("Email", this._email, false),
          // spacing
          SizedBox(height: 10.0),
          // password
          _buildTextField("Password", this._password, true),

          // term and condition
          Container(
              padding: EdgeInsets.only(top: 15.0),
              child: SwitchListTile(
                  value: this._acceptTerms,
                  title: Text("Accept Terms",
                      style: TextStyle(color: Colors.grey)),
                  onChanged: (bool value) {
                    setState(() {
                      this._acceptTerms = value;
                    });
                  })),

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
        ]))));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  }
}
