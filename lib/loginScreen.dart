import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meow_lastest/mainScreen.dart';
import 'package:meow_lastest/registerScreen.dart';
import 'package:meow_lastest/user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight;
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _pwEditingController = new TextEditingController();
  String urlLogin = "https://seriouslaa.com/meow/php/login_user.php";

  @override
  void initState() {
    super.initState();
    print("Hello I'm in INITSTATE");
    this.loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/meowlogin.PNG'),
                          fit: BoxFit.fill))),
              Container(
                margin: EdgeInsets.only(top: screenHeight / 3),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(children: <Widget>[
                  Card(
                    color: Colors.deepOrange[100],
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: TextField(
                            controller: _emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: TextField(
                            controller: _pwEditingController,
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _forgotPassword,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange[900]),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Checkbox(
                              value: rememberMe,
                              onChanged: (bool value) {
                                _onRememberMeChanged(value);
                              },
                            ),
                            Text('Remember Me ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              minWidth: 100,
                              height: 50,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              color: Colors.deepOrange[900],
                              elevation: 10,
                              onPressed: _userLogin,
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: _signUp,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an Account? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          )),
    ));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepOrange[900],
            title: new Text('Are you sure?',
                style: TextStyle(color: Colors.white)),
            content: new Text('Do you want to exit Meow App',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child:
                      Text("Exit", style: TextStyle(color: Colors.deepOrange[100]))),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel",
                      style: TextStyle(color: Colors.deepOrange[100]))),
            ],
          ),
        ) ??
        false;
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        print(rememberMe);
        if (rememberMe) {
          savepref(true);
        } else {
          savepref(false);
        }
      });

  void _userLogin() async {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in...");
      pr.show();
      String _email = _emailEditingController.text;
      String _password = _pwEditingController.text;
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.body);
        var string = res.body;
        List userdata = string.split(",");
        if (userdata[0] == "success") {
          User _user = new User(
              name: userdata[1],
              email: _email,
              password: _password,
              phone: userdata[3],
              credit: userdata[4],
              datereg: userdata[5],
              quantity: userdata[6]);
          pr.hide();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainScreen(
                        user: _user,
                      )));
        } else {
          pr.hide();
          Toast.show("Login failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
    } on Exception catch (_) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _signUp() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailEditingController.text = email;
        _pwEditingController.text = password;
        rememberMe = true;
      });
    }
  }

  void savepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _pwEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Toast.show("Preferences have been saved", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _pwEditingController.text = '';
        rememberMe = false;
      });
      Toast.show("Preferences have removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void _forgotPassword() {
    TextEditingController phoneController = TextEditingController();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.deepOrange[900],
          title: new Text(
            "Forgot Password?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Text(
                  "Enter your recovery email",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      icon: Icon(Icons.email, color: Colors.white),
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.deepOrange[100],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                print(
                  phoneController.text,
                );
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.deepOrange[100],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
