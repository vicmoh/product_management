import "package:flutter/material.dart";
import "./products.dart";
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

enum AuthMode { Signup, Login }

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
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  _setEmail(String value) {
    this._loginData['email'] = value;
  }

  _setPassword(String value) {
    this._loginData['password'] = value;
  }

  String _validateString(String toBeValidate) {
    if (toBeValidate.isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }

  String _validateEmail(String toBeValidate) {
    if (_emailController.text != toBeValidate) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String _validatePass(String toBeValidate) {
    if (_passController != toBeValidate) {
      return 'Password is invalid';
    }
    return null;
  }

  _submitLogin(Function login) {
    if (!_loginKey.currentState.validate()) {
      return;
    } else if (_loginData['acceptTerm'] == false) {
      // term condition
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
    login(_loginData['email'], _loginData['password']);
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
  Widget _buildTextField(String label, bool isObscure, Function setter,
      Function validator, TextEditingController controller) {
    return TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
            labelText: label, filled: true, fillColor: Colors.white),
        validator: validator,
        controller: controller,
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
                  _buildTextField("Email", false, _setEmail, _validateEmail,
                      _emailController),
                  SizedBox(height: 10.0),

                  // password
                  _buildTextField("Password", true, _setPassword, _validatePass,
                      _passController),
                  SizedBox(height: 10.0),

                  // confirm password
                  _buildTextField("Confirm Password", true, _setPassword,
                      _validatePass, _confirmPassController),

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

                  // buttons
                  ScopedModelDescendant<MainModel>(builder:
                      (BuildContext context, Widget child, MainModel model) {
                    return Container(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // login button
                            Container(
                              child: RaisedButton(
                                child: Text("Login"),
                                textColor: Colors.white,
                                color: Theme.of(context).accentColor,
                                onPressed: () => _submitLogin(model.login),
                              ),
                            ),

                            // sign up button
                            Container(
                              child: FlatButton(
                                child: Text("Sign Up"),
                                onPressed: () {
                                  setState(() {
                                    _authMode = _authMode == AuthMode.Login
                                        ? AuthMode.Signup
                                        : AuthMode.Login;
                                  });
                                },
                              ),
                            ),
                          ],
                        ));
                  }),
                ]))))));
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  }
}
