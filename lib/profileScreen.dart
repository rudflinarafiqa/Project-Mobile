import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'loginScreen.dart';
import 'registerScreen.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:meow_lastest/storeCredit.dart';
import 'package:meow_lastest/adminScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  String server = "https://seriouslaa.com/meow";
  double screenHeight, screenWidth;
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  var parsedDate;
  bool _visible = false;
  bool _isadmin = false;

  @override
  void initState() {
    super.initState();
    print("Profile Screen");
    refreshKey = GlobalKey<RefreshIndicatorState>();
    if (widget.user.email == "admin@meow.com") {
      _isadmin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    parsedDate = DateTime.parse(widget.user.datereg);

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange[900],
              title: Text(
                'Me',
                style: GoogleFonts.averiaSansLibre(
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: _visible
                      ? new Icon(Icons.expand_more)
                      : new Icon(Icons.settings),
                  onPressed: () {
                    setState(() {
                      if (_visible) {
                        _visible = false;
                      } else {
                        _visible = true;
                      }
                    });
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              key: refreshKey,
              color: Colors.deepOrange[900],
              onRefresh: () async {
                await refreshList();
              },
              child: Center(
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: _visible,
                      child: Container(
                        height: screenHeight / 5,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              color: Colors.deepOrange[900],
                              child: Center(
                                child: Text("Update User Profile",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ),
                            ListTile(
                                leading:
                                    Icon(MdiIcons.account, color: Colors.black),
                                title: Text(
                                  "Change Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: changeName),
                            ListTile(
                                leading:
                                    Icon(MdiIcons.key, color: Colors.black),
                                title: Text(
                                  "Change Password",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: changePassword),
                            ListTile(
                                leading:
                                    Icon(MdiIcons.phone, color: Colors.black),
                                title: Text(
                                  "Change Phone Number",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: changePhoneNumber),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: _takePicture,
                                  child: Container(
                                    height: screenHeight / 4,
                                    width: screenWidth / 2,
                                    child: CachedNetworkImage(
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      imageUrl: server +
                                          "/profileimage/meow.png?",
                                      placeholder: (context, url) =>
                                          new SizedBox(
                                              height: 10.0,
                                              width: 10.0,
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          new Icon(MdiIcons.cameraIris,
                                              size: 64.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Table(
                                  defaultColumnWidth: FlexColumnWidth(2.0),
                                  columnWidths: {
                                    0: FlexColumnWidth(3.5),
                                    1: FlexColumnWidth(6.5),
                                  },
                                  children: [
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 20,
                                            child: Text("Name",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black))),
                                      ),
                                      TableCell(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 20,
                                          child: Text(widget.user.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 20,
                                            child: Text("Email",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black))),
                                      ),
                                      TableCell(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 20,
                                          child: Text(widget.user.email,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 20,
                                            child: Text("Phone",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black))),
                                      ),
                                      TableCell(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 20,
                                          child: Text(widget.user.phone,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: 20,
                                            child: Text("Register Date",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black))),
                                      ),
                                      TableCell(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 20,
                                          child: Text(f.format(parsedDate),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ]),
                                  ]),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Divider(
                              height: 2,
                              color: Colors.deepOrange[900],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Store Credit",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("RM " + widget.user.credit,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.deepOrange[900]))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                          height: screenHeight / 4,
                          color: Colors.deepOrange[100],
                          child: ListView(children: <Widget>[
                            ListTile(
                                leading: Icon(Icons.attach_money,
                                    color: Colors.black),
                                title: Text(
                                  "Buy Store Credit",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: buyStoreCredit),
                            ListTile(
                                leading:
                                    Icon(MdiIcons.login, color: Colors.black),
                                title: Text(
                                  "Login Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: _gotologinPage),
                            ListTile(
                                leading: Icon(MdiIcons.accountPlus,
                                    color: Colors.black),
                                title: Text(
                                  "Register New Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Icon(MdiIcons.arrowRightCircle,
                                    color: Colors.black),
                                onTap: _registerAccount),
                            Visibility(
                              visible: _isadmin,
                              child: Column(
                                children: <Widget>[
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    color: Colors.deepOrange[900],
                                    child: Center(
                                      child: Text("Admin Menu",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  ListTile(
                                      leading: Icon(MdiIcons.tshirtCrew,
                                          color: Colors.black),
                                      title: Text(
                                        "My Products",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      trailing: Icon(MdiIcons.arrowRightCircle,
                                          color: Colors.black),
                                      onTap: () => {
                                            Navigator.pop(context),
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        AdminScreen(
                                                          user: widget.user,
                                                        )))
                                          }),
                                  //ListTile(
                                  //leading: Icon(MdiIcons.clipboardText, color: Colors.black),
                                  //title: Text(
                                  //"Customer Orders",
                                  //style: TextStyle(
                                  //color: Colors.black,
                                  //),
                                  //),
                                  //trailing: Icon(MdiIcons.arrowRightCircle, color: Colors.black),
                                  //),
                                ],
                              ),
                            )
                          ])),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _takePicture() async {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Unregister account only display default image", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@meow.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    // ignore: deprecated_member_use
    File _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 400, maxWidth: 300);
    // print(_image.lengthSync());
    if (_image == null) {
      Toast.show("Please take image first", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      String base64Image = base64Encode(_image.readAsBytesSync());
      print(base64Image);
      http.post(server + "/php/upload_image.php", body: {
        "encoded_string": base64Image,
        "email": widget.user.email,
      }).then((res) {
        print(res.body);
        if (res.body == "success") {
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
          });
        } else {
          Toast.show("Failed", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  void changeName() {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@meow.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.deepOrange[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your name?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.person,
                      color: Colors.deepOrange[100],
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.deepOrange[100],
                      ),
                    ),
                    onPressed: () =>
                        _changeName(nameController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.deepOrange[100],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changeName(String name) {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (name == "" || name == null) {
      Toast.show("Please enter your new name", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    ReCase rc = new ReCase(name);
    print(rc.titleCase.toString());
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "name": rc.titleCase.toString(),
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.name = rc.titleCase;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePassword() {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController passController = TextEditingController();
    TextEditingController pass2Controller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.deepOrange[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your password?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.deepOrange[100],
                        ),
                      )),
                  TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: true,
                      controller: pass2Controller,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.lock,
                          color: Colors.deepOrange[100],
                        ),
                      )),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.deepOrange[100],
                      ),
                    ),
                    onPressed: () => updatePassword(
                        passController.text, pass2Controller.text)),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.deepOrange[100],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  updatePassword(String pass1, String pass2) {
    if (pass1 == "" || pass2 == "") {
      Toast.show("Please enter your password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "oldpassword": pass1,
      "newpassword": pass2,
    }).then((res) {
      if (res.body == "success") {
        print('in success');
        setState(() {
          widget.user.password = pass2;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void changePhoneNumber() {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController phoneController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.deepOrange[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Change your name?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'New Phone Number',
                    labelStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.phone,
                      color: Colors.deepOrange[100],
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.deepOrange[100],
                      ),
                    ),
                    onPressed: () =>
                        _changePhone(phoneController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(
                      color: Colors.deepOrange[100],
                    ),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _changePhone(String phone) {
    if (phone == "" || phone == null || phone.length < 9) {
      Toast.show("Please enter your new phone number", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    http.post(server + "/php/update_profile.php", body: {
      "email": widget.user.email,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        print('in success');

        setState(() {
          widget.user.phone = phone;
        });
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
        return;
      } else {}
    }).catchError((err) {
      print(err);
    });
  }

  void _gotologinPage() {
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Go to login page?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.white,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
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

  void _registerAccount() {
    // flutter defined function
    print(widget.user.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.deepOrange[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Register new account?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: new Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.white,
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

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RegisterScreen()));
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

  void buyStoreCredit() {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@meow.com") {
      Toast.show("Admin Mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    TextEditingController creditController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.deepOrange[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Buy Store Credit?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: new TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: creditController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter RM',
                    icon: Icon(
                      Icons.attach_money,
                      color: Color.fromRGBO(101, 255, 218, 50),
                    ),
                  )),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.deepOrange[100],
                      ),
                    ),
                    onPressed: () =>
                        _buyCredit(creditController.text.toString())),
                new FlatButton(
                  child: new Text(
                    "No",
                    style: TextStyle(color: Colors.deepOrange[100]),
                  ),
                  onPressed: () => {Navigator.of(context).pop()},
                ),
              ]);
        });
  }

  _buyCredit(String cr) {
    print("RM " + cr);
    if (cr.length <= 0) {
      Toast.show("Please enter correct amount", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.deepOrange[900],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Buy store credit RM ' + cr,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: new Text(
          'Are you sure?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => StoreCreditScreen(
                              user: widget.user,
                              val: cr,
                            )));
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.deepOrange[100],
                ),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.deepOrange[100],
                ),
              )),
        ],
      ),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));

    return null;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepOrange[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: new Text(
              'Do you want to exit Meow App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                      color: Colors.deepOrange[100],
                    ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.deepOrange[100],
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }
}
