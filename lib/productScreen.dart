import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meow_lastest/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final User user;

  const ProductScreen({Key key, this.user}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List productdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  String titlecenter = "Loading products...";
  String server = "https://seriouslaa.com/meow";

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadCartQuantity();

    refreshKey = GlobalKey<RefreshIndicatorState>();
    print("Product Screen");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _prdController = new TextEditingController();
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange[900],
            title: Text(
              'Product List',
              style: GoogleFonts.averiaSansLibre(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: _visible
                    ? new Icon(Icons.expand_more)
                    : new Icon(Icons.search),
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Visibility(
                        visible: _visible,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: screenHeight / 12.5,
                            margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Flexible(
                                    child: Container(
                                  height: 30,
                                  child: TextField(
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      autofocus: false,
                                      controller: _prdController,
                                      decoration: InputDecoration(
                                          labelText: 'Search Product',
                                          border: OutlineInputBorder())),
                                )),
                                Flexible(
                                    child: MaterialButton(
                                  color: Colors.deepOrange[900],
                                  onPressed: () =>
                                      {_sortItembyName(_prdController.text)},
                                  elevation: 5,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )),
                    Card(
                        elevation: 10,
                        child: Padding(
                            padding: EdgeInsets.all(4),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          onPressed: () => _sortItem("Recent"),
                                          color: Colors.deepOrange[900],
                                          textColor: Colors.white,
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Recent",
                                                style: GoogleFonts.capriola(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          onPressed: () => _sortItem("Food"),
                                          color: Colors.deepOrange[900],
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Food",
                                                style: GoogleFonts.capriola(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          onPressed: () => _sortItem("Carrier"),
                                          color: Colors.deepOrange[900],
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Carrier",
                                                style: GoogleFonts.capriola(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          onPressed: () =>
                                              _sortItem("Cat Little"),
                                          color: Colors.deepOrange[900],
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Cat Little",
                                                style: GoogleFonts.capriola(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          onPressed: () =>
                                              _sortItem("Cage"),
                                          color: Colors.deepOrange[900],
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Cage",
                                                style: GoogleFonts.capriola(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ))),
                    Text(curtype,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    productdata == null
                        ? Flexible(
                            child: Container(
                                child: Center(
                                    child: Text(
                            titlecenter,
                            style: TextStyle(
                                color: Colors.deepOrange[900],
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ))))
                        : Expanded(
                            child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (screenWidth / screenHeight) / 0.8,
                                children:
                                    List.generate(productdata.length, (index) {
                                  return Container(
                                      child: Card(
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () =>
                                                      _onImageDisplay(index),
                                                  child: Container(
                                                    height: screenHeight / 6,
                                                    width: screenWidth / 3,
                                                    child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl: server +
                                                          "/productimage/${productdata[index]['id']}.jpg",
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(Icons.error),
                                                    )),
                                                  ),
                                                ),
                                                Text(productdata[index]['name'],
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                                Text(
                                                  "RM " +
                                                      productdata[index]
                                                          ['price'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "Quantity available:" +
                                                      productdata[index]
                                                          ['quantity'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "Size:" +
                                                      productdata[index]
                                                          ['size'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  minWidth: 70,
                                                  height: 30,
                                                  child: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.deepOrange[900],
                                                  elevation: 10,
                                                  onPressed: () =>
                                                      _addtocartdialog(index),
                                                ),
                                              ],
                                            ),
                                          )));
                                })))
                  ],
                ),
              )),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange[400],
            onPressed: () async {
              if (widget.user.email == "unregistered@meow.com") {
                Toast.show("Please register to use this function", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.email == "admin@meow.com") {
                Toast.show("Admin mode!!!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else if (widget.user.quantity == "0") {
                Toast.show("Cart empty", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                return;
              } else {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CartScreen(
                              user: widget.user,
                            )));
                _loadData();
                _loadCartQuantity();
              }
            },
            icon: Icon(Icons.shopping_cart),
            label: Text(cartquantity),
          ),
        ));
  }

  _onImageDisplay(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              color: Colors.white,
              height: screenHeight / 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: screenWidth / 1.5,
                      width: screenWidth / 1.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: NetworkImage(server +
                                  "/productimage/${productdata[index]['id']}.jpg")))),
                ],
              ),
            ));
      },
    );
  }

  void _loadData() async {
    String urlLoadJobs = server + "/php/load_products.php";
    await http.post(urlLoadJobs, body: {}).then((res) {
      if (res.body == "nodata") {
        cartquantity = "0";
        titlecenter = "No product found";
        setState(() {
          productdata = null;
        });
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          productdata = extractdata["products"];
          cartquantity = widget.user.quantity;
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadCartQuantity() async {
    String urlLoadJobs = server + "/php/load_cartquantity.php";
    await http.post(urlLoadJobs, body: {
      "email": widget.user.email,
    }).then((res) {
      if (res.body == "nodata") {
      } else {
        widget.user.quantity = res.body;
      }
    }).catchError((err) {
      print(err);
    });
  }

  _addtocartdialog(int index) {
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
    quantity = 1;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newSetState) {
            return AlertDialog(
              backgroundColor: Colors.deepOrange[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text(
                "Add " + productdata[index]['name'] + " to Cart?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Select quantity of product",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.minus,
                              color: Colors.deepOrange[100],
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              newSetState(() {
                                if (quantity <
                                    (int.parse(productdata[index]['quantity']) -
                                        2)) {
                                  quantity++;
                                } else {
                                  Toast.show("Quantity not available", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              })
                            },
                            child: Icon(
                              MdiIcons.plus,
                              color: Colors.deepOrange[100],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      _addtoCart(index);
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
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.deepOrange[100],
                      ),
                    )),
              ],
            );
          });
        });
  }

  void _addtoCart(int index) {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register first", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    if (widget.user.email == "admin@meow.com") {
      Toast.show("Admin mode", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    try {
      int cquantity = int.parse(productdata[index]["quantity"]);
      print(cquantity);
      print(productdata[index]["id"]);
      print(widget.user.email);
      if (cquantity > 0) {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal, isDismissible: true);
        pr.style(message: "Add to cart...");
        pr.show();
        String urlLoadJobs = server + "/php/insert_cart.php";
        http.post(urlLoadJobs, body: {
          "email": widget.user.email,
          "proid": productdata[index]["id"],
          "quantity": quantity.toString(),
        }).then((res) {
          print(res.body);
          if (res.body == "failed") {
            Toast.show("Failed add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.hide();
            return;
          } else {
            List respond = res.body.split(",");
            setState(() {
              cartquantity = respond[1];
              widget.user.quantity = cartquantity;
            });
            Toast.show("Success add to cart", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
          pr.hide();
        }).catchError((err) {
          print(err);
          pr.hide();
        });
        pr.hide();
      } else {
        Toast.show("Out of stock", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show("Failed add to cart", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortItem(String type) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = server + "/php/load_products.php";
      http.post(urlLoadJobs, body: {
        "type": type,
      }).then((res) {
        if (res.body == "nodata") {
          setState(() {
            productdata = null;
            curtype = type;
            titlecenter = "No product found";
          });
          pr.hide();
        } else {
          setState(() {
            curtype = type;
            var extractdata = json.decode(res.body);
            productdata = extractdata["products"];
            FocusScope.of(context).requestFocus(new FocusNode());
            pr.hide();
          });
        }
      }).catchError((err) {
        print(err);
        pr.hide();
      });
      pr.hide();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _sortItembyName(String prname) {
    try {
      print(prname);
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs = server + "/php/load_products.php";
      http
          .post(urlLoadJobs, body: {
            "name": prname.toString(),
          })
          .timeout(const Duration(seconds: 4))
          .then((res) {
            if (res.body == "nodata") {
              Toast.show("Product not found", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              pr.hide();
              setState(() {
                titlecenter = "No product found";
                curtype = "search for " + "'" + prname + "'";
                productdata = null;
              });
              FocusScope.of(context).requestFocus(new FocusNode());

              return;
            } else {
              setState(() {
                var extractdata = json.decode(res.body);
                productdata = extractdata["products"];
                FocusScope.of(context).requestFocus(new FocusNode());
                curtype = "search for " + "'" + prname + "'";
                pr.hide();
              });
            }
          })
          .catchError((err) {
            pr.hide();
          });
      pr.hide();
    } on TimeoutException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } on SocketException catch (_) {
      Toast.show("Time out", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  gotoCart() async {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.email == "admin@meow.com") {
      Toast.show("Admin mode!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else if (widget.user.quantity == "0") {
      Toast.show("Cart empty", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
      _loadData();
      _loadCartQuantity();
    }
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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    _loadData();
    return null;
  }
}