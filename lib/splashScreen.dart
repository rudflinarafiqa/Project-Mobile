import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'mainScreen.dart';
import 'user.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.deepOrange[900],
        cardColor: Colors.deepOrange[100],
        textTheme: GoogleFonts.averiaSansLibreTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Meow',
      home: Scaffold(
          body: Container(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/meow.PNG'),
                        fit: BoxFit.cover))),
            Container(height: 1000, child: ProgressIndicator())
          ],
        ),
      )),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 2.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            controller.stop();
            loadpref(this.context);
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      child: CircularProgressIndicator(
        value: animation.value,
        backgroundColor: Colors.brown,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ));
  }

  void loadpref(BuildContext ctx) async {
    print('Inside loadpref()');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email') ?? '');
    String pass = (prefs.getString('pass') ?? '');
    print("Splash:Preference" + email + "/" + pass);
    if (email.length > 5) {
      loginUser(email, pass, ctx);
    } else {
      loginUser("unregistered", "123456789", ctx);
    }
  }

  void loginUser(String email, String pass, BuildContext ctx) {
    http.post("https://seriouslaa.com/meow/php/login_user.php", body: {
      "email": email,
      "password": pass,
    }).then((res) {
      print(res.body);
      var string = res.body;
      List userdata = string.split(",");
      if (userdata[0] == "success") {
        User _user = new User(
            name: userdata[1],
            email: email,
            password: pass,
            phone: userdata[3],
            credit: userdata[4],
            datereg: userdata[5],
            quantity: userdata[6]);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                      user: _user,
                    )));
      } else {
        Toast.show(
            "Fail to login with stored credential. Login as unregistered account.",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        loginUser("myname@gmail.com", "meow", ctx);
      }
    }).catchError((err) {
      print(err);
    });
  }
}
