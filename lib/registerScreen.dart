import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meow_lastest/loginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String name, phone, email, password;
  double screenHeight;
  bool _isChecked = false;
  bool _obscureText = true;

  String urlRegister =
      "http://www.seriouslaa.com/meow/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController _pwEditingController = new TextEditingController();

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
                          image: AssetImage('assets/images/meowres.PNG'),
                          fit: BoxFit.fill))),
              new Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: registrationForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registrationForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 4),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(children: <Widget>[
        Card(
          color: Colors.deepOrange[100],
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: TextFormField(
                    controller: _nameEditingController,
                    validator: validateName,
                    onSaved: (String val) {
                      name = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: TextFormField(
                    controller: _phoneEditingController,
                    validator: validatePhone,
                    onSaved: (String val) {
                      phone = val;
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: TextFormField(
                    controller: _emailEditingController,
                    validator: validateEmail,
                    onSaved: (String val) {
                      email = val;
                    },
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
                  child: TextFormField(
                    controller: _pwEditingController,
                    validator: validatePassword,
                    onSaved: (String val) {
                      password = val;
                    },
                    obscureText: _obscureText,
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
                  child: FlatButton(
                    onPressed: _toggle,
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        _onChange(value);
                      },
                    ),
                    GestureDetector(
                      onTap: _showEULA,
                      child: Text('I have Read and Agree to Terms  ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  minWidth: 120,
                  height: 50,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
                  ),
                  color: Colors.deepOrange[900],
                  textColor: Colors.white,
                  elevation: 10,
                  onPressed: _onSignUp,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: _signIn,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Have an Account? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validatePhone(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone Number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    }
    return null;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Meow App'),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text("Exit")),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancel")),
            ],
          ),
        ) ??
        false;
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _showEULA() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange[900],
          title: new Text(
            "End-User License Agreement (EULA) of Meow",
            style: TextStyle(color: Colors.white),
          ),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                          text:
                              "This End-User License Agreement is a legal agreement between you and Seriouslaa. This EULA agreement governs your acquisition and use of our Meow software (Software) directly from Seriouslaa or indirectly through a Seriouslaa authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the Meow software. It provides a license to use the Meow software and contains warranty information and liability disclaimers. If you register for a free trial of the Meow software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the Meow software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Seriouslaa herewith regardless of whether other software is referred to or described herein. The terms also apply to any Seriouslaa updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for Meow. Seriouslaa shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Seriouslaa. Seriouslaa reserves the right to grant licences to use the Software to third parties",
                        )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.deepOrange[100]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _onSignUp() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String password = _pwEditingController.text;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }

    if (!_isChecked) {
      Toast.show("Please Read and Agree to Terms", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.deepOrange[900],
        title: new Text('Are you sure?', style: TextStyle(color: Colors.white)),
        content: new Text('Do you want to Sign Up',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              http.post(urlRegister, body: {
                "name": name,
                "phone": phone,
                "email": email,
                "password": password,
              }).then((res) {
                if (res.body == "success") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                  Toast.show("Sign Up Successful", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else {
                  Toast.show("Sign Up Failed", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              }).catchError((err) {
                print(err);
              });
            },
            child: Text("Yes", style: TextStyle(color: Colors.deepOrange[100])),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel", style: TextStyle(color: Colors.deepOrange[100])),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _signIn() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.deepOrange[900],
        title: new Text(
          'Are you sure?',
          style: TextStyle(color: Colors.white),
        ),
        content: new Text('Do you want leave Sign Up Page',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
              },
              child: Text("Leave", style: TextStyle(color: Colors.deepOrange[100]))),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.deepOrange[100]))),
        ],
      ),
    );
  }
}