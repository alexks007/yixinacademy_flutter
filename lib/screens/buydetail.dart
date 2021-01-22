import 'package:Juhuischool/screens/Coursedetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Juhuischool/screens/startpage.dart';
import 'package:Juhuischool/screens/login2_screen.dart';
import 'package:http/http.dart' as http;
import 'package:Juhuischool/screens/prizedetail.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

int cardnum = 0;
int cvv = 0;
int send_month = 0;
int send_year = 0;
String couponcode = "";


_onBasicAlertPressed(context,fullname,password) {
  Alert(
    context: context,
    title: fullname,
    desc: password,
  ).show();
}

Future<String> postMoney() async {
  final uri = 'https://class.yixinacademy.com/api/user/postmoney';
  var  requestBody = {
    'cardNumber': cardnum.toString(),
    'month': send_month.toString(),
    'year': send_year.toString(),
    'cardCVC': cvv.toString(),
    'title': current_title,
    'price': current_price.toString(),
    'type': current_type,
    'id': user_id.toString(),
    'couponcode': couponcode
  };
  
  http.Response response = await http.post(uri,body: requestBody);

  var responseObj = json.decode(response.body);
  return responseObj.toString();
}

class Buydetail extends StatefulWidget {
  @override
  _BuydetailState createState() => _BuydetailState();
}

class _BuydetailState extends State<Buydetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //data
  int radiovalue = 0;
  String paylah = '';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    var size = MediaQuery.of(context).size;

    TextStyle maintextstyle = new TextStyle(
        color: Colors.black,
        fontSize: 18 * size.width / 390,
        fontWeight: FontWeight.bold);
    TextStyle subtextstyle =
        new TextStyle(color: Colors.black, fontSize: 17 * size.width / 390);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menulist(),
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //logo
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(20 * size.height / 750),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 80 * size.height / 750,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(_createRoutetomain());
              },
            ),
            SizedBox(
              height: 30 * size.height / 750,
            ),
            //payment info
            Container(
              padding: EdgeInsets.all(20 * size.width / 390),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://class.yixinacademy.com/assets/images/courses/${prizeimage[prizepos]}',
                          width: 100 * size.width / 390,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          current_title,
                          style: TextStyle(
                            fontSize: 15 * size.width / 390,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'S\u{24}' + current_price.toString(),
                          style: TextStyle(
                            fontSize: 15 * size.width / 390,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 60 * size.height / 750,
                  ),
                  Text(
                    'Payment Info',
                    style: maintextstyle,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    width: size.width,
                    height: 2,
                    color: Colors.grey[400],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        activeColor: Colors.grey[900],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: radiovalue,
                        onChanged: (value) {
                          setState(() {
                            radiovalue = value;
                          });
                        },
                      ),
                      Text(
                        ' Paynow',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        activeColor: Colors.grey[900],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: radiovalue,
                        onChanged: (value) {
                          setState(() {
                            radiovalue = value;
                          });
                        },
                      ),
                      Text(
                        ' Stripe/Visa? 付款方式',
                        style: subtextstyle,
                      )
                    ],
                  ),
                  if (radiovalue == 0)
                    Container(
                      child:Image.network(
                        'https://class.yixinacademy.com/assets/images/paynow/${current_title}.png',
                        width: size.width,
                        height: size.height - 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  if(radiovalue == 1) 
                    Container(
                      child:Column (
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: new TextFormField(
                              initialValue: "",
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "Enter Card Number",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                              ),
                              onChanged: (String tval) {
                                setState(() {
                                  cardnum = int.parse(tval);
                                });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: new TextFormField(
                              initialValue: "",
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "Enter CVC",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                              ),
                              onChanged: (String tval) {
                                setState(() {
                                  cvv = int.parse(tval);
                                });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: new TextFormField(
                              initialValue: "",
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "Enter Year",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                              ),
                              onChanged: (String tval) {
                                setState(() {
                                  send_year = int.parse(tval);
                                });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: new TextFormField(
                              initialValue: "",
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "Enter Month",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                              ),
                              onChanged: (String tval) {
                                setState(() {
                                  send_month = int.parse(tval);
                                });
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: new TextFormField(
                              initialValue: "",
                              decoration: new InputDecoration(
                                labelText: "Enter Couponcode",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                              ),
                              onChanged: (String tval) {
                                setState(() {
                                  couponcode = tval;
                                });
                              }
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              padding: EdgeInsets.fromLTRB(
                                  20 * size.width / 390, 6, 20 * size.width / 390, 6),
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Text(
                                'CONTINUE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30 * size.height / 750,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () async{
                              if(cardnum == 0) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Card Num is empty")));
                              else if(cvv == 0) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("CVV is empty")));
                              else if(send_month == 0) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Month is empty")));
                              else if(send_year == 0) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Year is empty")));
                              else if(couponcode == null) _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("CouponCode is empty")));
                              else {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: Container(
                                          width: 300,
                                          height: 300,
                                          child:new Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Center(
                                                child: new SizedBox(
                                                  height: 50.0,
                                                  width: 50.0,
                                                  child: new CircularProgressIndicator(
                                                    value: null,
                                                    strokeWidth: 7.0,
                                                  ),
                                                ),
                                              ),
                                              new Container(
                                                margin: const EdgeInsets.only(top: 25.0),
                                                child: new Center(
                                                  child: new Text(
                                                    "loading.. wait...",
                                                    style: new TextStyle(
                                                      color: Colors.blue
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  
                                  String get_msg = await postMoney();
                                  Navigator.pop(context); //pop dialog
                                  if(get_msg != "true") _onBasicAlertPressed(context,"UnSuccess",get_msg);
                                  else {
                                    await getCatalogInformation();
                                    Navigator.of(context).push(_createRoutetocourse());
                                  }
                              }
                            },
                          )
                        ],
                      )
                    ),
                  /*
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          3 * size.width / 390,
                          10 * size.width / 390,
                          3 * size.width / 390,
                          10 * size.width / 390),
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(5 * size.width / 390),
                          border: Border.all(width: 2, color: Colors.grey)),
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          paylah = value;
                        },
                      ),
                    ),
                    */
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoutetomain() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Startpage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoutetocourse() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Coursedetail(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
