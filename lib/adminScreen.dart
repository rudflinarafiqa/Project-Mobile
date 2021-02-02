import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:meow_lastest/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meow_lastest/editProduct.dart';
import 'package:meow_lastest/newProduct.dart';
import 'package:meow_lastest/product.dart';
import 'package:meow_lastest/user.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'cartScreen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  final User user;

  const AdminScreen({Key key, this.user}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List productdata;
  int curnumber = 1;
  double screenHeight, screenWidth;
  bool _visible = false;
  String curtype = "Recent";
  String cartquantity = "0";
  int quantity = 1;
  String titlecenter = "Loading products...";
  var _tapPosition;
  String server = "https://seriouslaa.com/meow";
  String scanPrId;

  @override
  void initState() {
    super.initState();
    _loadData();
    print("Admin Screen");
    refreshKey = GlobalKey<RefreshIndicatorState>();
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
              'Manage Your Products',
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
                                      onPressed: () => {
                                            _sortItembyName(_prdController.text)
                                          },
                                      elevation: 5,
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      )))
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
                                        onPressed: () => _sortItem("Cat Little"),
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
                                  (screenWidth / screenHeight) / 0.65,
                              children:
                                  List.generate(productdata.length, (index) {
                                return Container(
                                    child: InkWell(
                                        onTap: () => _showPopupMenu(index),
                                        onTapDown: _storePosition,
                                        child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height: screenHeight / 6,
                                                    width: screenWidth / 3,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.fill,
                                                        imageUrl: server +
                                                            "/productimage/${productdata[index]['id']}.jpg",
                                                        placeholder: (context,
                                                                url) =>
                                                            new CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            new Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                      productdata[index]
                                                          ['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
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
                                                    "Avail/Sold:" +
                                                        productdata[index]
                                                            ['quantity'] +
                                                        "/" +
                                                        productdata[index]
                                                            ['sold'],
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
                                                ],
                                              ),
                                            ))));
                              })))
                ],
              ),
            ),
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: Colors.deepOrange[300],
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                  child: Icon(MdiIcons.tshirtV),
                  backgroundColor: Colors.deepOrange[300],
                  label: "New Product",
                  labelStyle: TextStyle(color: Colors.white),
                  labelBackgroundColor: Colors.deepOrange[300],
                  onTap: createNewProduct),
              SpeedDialChild(
                  child: Icon(MdiIcons.barcodeScan),
                  backgroundColor: Colors.deepOrange[300],
                  label: "Scan Product",
                  labelStyle: TextStyle(color: Colors.white),
                  labelBackgroundColor: Colors.deepOrange[300], //_changeLocality()
                  onTap: () => scanProductDialog()),
            ],
          ),
        ));
  }

  void scanProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.deepOrange[900],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Select scan options:",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                  color: Colors.deepOrange[100],
                  onPressed: scanBarcodeNormal,
                  elevation: 5,
                  child: Text(
                    "Bar Code",
                    style: TextStyle(color: Colors.black),
                  )),
              MaterialButton(
                  color: Colors.deepOrange[100],
                  onPressed: scanQR,
                  elevation: 5,
                  child: Text(
                    "QR Code",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          ),
        );
      },
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }

  void _loadSingleProduct(String prid) {
    String urlLoadJobs = server + "/php/load_products.php";
    http.post(urlLoadJobs, body: {
      "prid": prid,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        Toast.show("Not found", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        setState(() {
          var extractdata = json.decode(res.body);
          productdata = extractdata["products"];
          print(productdata);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if (barcodeScanRes == "-1") {
        scanPrId = "";
      } else {
        scanPrId = barcodeScanRes;
        Navigator.of(context).pop();
        _loadSingleProduct(scanPrId);
      }
    });
  }

  void _loadData() {
    String urlLoadJobs = server + "/php/load_products.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      print(res.body);
      setState(() {
        var extractdata = json.decode(res.body);
        productdata = extractdata["products"];
        cartquantity = widget.user.quantity;
      });
    }).catchError((err) {
      print(err);
    });
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
            curtype = type;
            titlecenter = "No product found";
            productdata = null;
          });
          pr.hide();
          return;
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
              FocusScope.of(context).requestFocus(new FocusNode());
              return;
            }
            setState(() {
              var extractdata = json.decode(res.body);
              productdata = extractdata["products"];
              FocusScope.of(context).requestFocus(new FocusNode());
              curtype = prname;
              pr.hide();
            });
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

  gotoCart() {
    if (widget.user.email == "unregistered@meow.com") {
      Toast.show("Please register to use this function", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => CartScreen(
                    user: widget.user,
                  )));
    }
  }

  _onProductDetail(int index) async {
    print(productdata[index]['name']);
    Product product = new Product(
        id: productdata[index]['id'],
        name: productdata[index]['name'],
        price: productdata[index]['price'],
        quantity: productdata[index]['quantity'],
        size: productdata[index]['size'],
        type: productdata[index]['type'],
        date: productdata[index]['date']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditProduct(
                  user: widget.user,
                  product: product,
                )));
    _loadData();
  }

  _showPopupMenu(int index) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
      context: context,
      color: Colors.deepOrange,
      position: RelativeRect.fromRect(
          _tapPosition & Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _onProductDetail(index)},
              child: Text(
                "Update Product?",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
        PopupMenuItem(
          child: GestureDetector(
              onTap: () =>
                  {Navigator.of(context).pop(), _deleteProductDialog(index)},
              child: Text(
                "Delete Product?",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _deleteProductDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: new Text(
            "Delete Product Id " + productdata[index]['id'],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content:
              new Text("Are you sure?", style: TextStyle(color: Colors.white)),
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
                _deleteProduct(index);
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

  void _deleteProduct(int index) {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Deleting product...");
    pr.show();
    String id = productdata[index]['id'];
    print("prid:" + id);
    http.post(server + "/php/delete_product.php", body: {
      "prid": id,
    }).then((res) {
      print(res.body);
      pr.hide();
      if (res.body == "success") {
        Toast.show("Delete success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _loadData();
        Navigator.of(context).pop();
      } else {
        Toast.show("Delete failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
      pr.hide();
    });
  }

  Future<void> createNewProduct() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => NewProduct()));
    _loadData();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    _loadData();
    return null;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: new Text(
              'Do you want to leave Manage Products',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainScreen(
                                  user: widget.user,
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
