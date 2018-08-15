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
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  var _loginData = {'email': '', 'password': '', 'acceptTerm': false};

  _setEmail(String value) {
    this._loginData['email'] = value;
  }

  _setPassword(String value) {
    this._loginData['password'] = value;
  }

  String _validataString(String toBeValidate) {
    if (toBeValidate.isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }

  _submitLogin() {
    if (!_loginKey.currentState.validate()) {
      return;
    } else if (_loginData['acceptTerm'] == false) {
      print("show alert:");
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  title: Text("Term and Condition"),
                  content: Text(
                      "Please accept the term and condition to continue.")));
      return;
    }
    _loginKey.currentState.save();
    print("---LOGIN---");
    print("email: " + this._loginData['email']);
    print("password: " + this._loginData['password']);
    Navigator.pushReplacementNamed(context, '/products');
  }

  // background image
  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'));
  } //end back img

  // textfield for user and pass etc
  Widget _buildTextField(String label, bool isObscure, Function setter) {
    return TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
            labelText: label, filled: true, fillColor: Colors.white),
        validator: _validataString,
        onSaved: (value) {
          setter(value);
        });
  } // textfield func

  // main login container
  Widget _loginContainer() {
    return Form(
        key: _loginKey,
        child: GestureDetector(
            onTap: () {
              // put keyboard down onces done
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                // imaage bakcground
                decoration: BoxDecoration(image: _buildBackgroundImage()),
                padding: EdgeInsets.all(15.0),

                // the login container
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                  // username
                  _buildTextField("Email", false, _setEmail),
                  // spacing
                  SizedBox(height: 10.0),
                  // password
                  _buildTextField("Password", true, _setPassword),

                  // term and condition
                  Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: SwitchListTile(
                          value: this._loginData['acceptTerm'],
                          title: Text("Accept Terms",
                              style: TextStyle(color: Colors.grey)),
                          onChanged: (bool value) {
                            setState(() {
                              this._loginData['acceptTerm'] = value;
                            });
                          })),

                  // login button
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: RaisedButton(
                      child: Text("Login"),
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                      onPressed: _submitLogin,
                    ),
                  ),
                ]))))));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  }
}
