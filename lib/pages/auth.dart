import "package:flutter/material.dart";
import "./products.dart";
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../scoped-models/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthPageState();
  }
}

class _AuthPageState extends State<StatefulWidget> {
  // dec instances
  GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  var _loginData = {'email': '', 'password': '', 'acceptTerm': false};
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  /// set email
  _setEmail(String value) {
    this._loginData['email'] = value;
  }

  /// set password
  _setPassword(String value) {
    this._loginData['password'] = value;
  }

  /// validate strings, if it is ok it will return
  /// null, else it will return a feedback
  String _validateRequiredString(String toBeValidate) {
    if (toBeValidate.isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }

  /// validate email, if it is ok it will return
  /// null, else it will return a feedback
  String _validateEmail(String toBeValidate) {
    if (_emailController.text != toBeValidate) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// validate pass, if it is ok it will return
  /// null, else it will return a feedback
  String _validatePass(String toBeValidate) {
    if (_passController.text != toBeValidate) {
      return 'Password is invalid';
    }
    return null;
  }

  /// submit a loginfunctions on auth page
  void _submitLogin(Function authenticate) async {
    if (!_loginKey.currentState.validate()) {
      return;
    } //end if
    _loginKey.currentState.save();

    // when signup page and acceptrm is not true
    if (_loginData['acceptTerm'] == false && _authMode == AuthMode.Signup) {
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
                        })
                  ],
                  title: Text("Term and Condition"),
                  content: Text(
                      "Please accept the term and condition to continue.")));
      return;
    } //end if

    // when on login page
    Map<String, dynamic> successInformation = await authenticate(
        _loginData['email'], _loginData['password'], _authMode);

    // when success
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text('An Error Occured'),
                  content: Text(successInformation['message']),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ]));
    } //end if

    // go to homepage
    print("---LOGIN---");
    print("email: " + this._loginData['email']);
    print("password: " + this._loginData['password']);
  } //end func

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
    var mainButtonString = _authMode == AuthMode.Login ? "Login" : "Sign Up";
    var switchToLoginOrSignUpString =
        _authMode == AuthMode.Login ? "Sign Up Page" : "Login Page";

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
              child: Column(
                children: <Widget>[
                  // username
                  _buildTextField("Email", false, _setEmail, _validateEmail,
                      _emailController),
                  SizedBox(height: 10.0),

                  // password
                  _buildTextField("Password", true, _setPassword,
                      _validateRequiredString, _passController),
                  SizedBox(height: 10.0),

                  // confirm password
                  _authMode == AuthMode.Signup
                      ? _buildTextField("Confirm Password", true, _setPassword,
                          _validatePass, _confirmPassController)
                      : Container(),

                  // term and condition
                  _authMode == AuthMode.Login
                      ? Container()
                      : Container(
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
                            // main login sign up button
                            Container(
                                child: model.isLoading
                                    ? CircularProgressIndicator()
                                    : RaisedButton(
                                        child: Text(mainButtonString),
                                        textColor: Colors.white,
                                        color: Theme.of(context).accentColor,
                                        onPressed: () =>
                                            _submitLogin(model.authenticate),
                                      )),

                            // switch login page or sign up page button
                            Container(
                              child: FlatButton(
                                child: Text(switchToLoginOrSignUpString),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  } //login container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        body: _loginContainer());
  } //end build
} //end class
