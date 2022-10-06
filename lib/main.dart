import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taktikseltakip/widgets/background-image.dart';

import 'anasayfa.dart';
import 'anasayfa2.dart';
// import 'package:login_page/anasayfa.dart';
// import 'package:login_page/anasayfa2.dart';
// import 'package:login_page/widgets/background-image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new login_page(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.asset(
                          "lib/assets/logo1.png",
                          fit: BoxFit.contain,
                        ),
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(55),
                            border: Border.all(
                                color: Colors.transparent, width: 30)),
                      ),

                      // child: Text(
                      //   'Tactical Tracking System',
                      //   style: TextStyle(
                      //       fontFamily: 'Anno',
                      //       fontSize: 27,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white),
                      // ),
                    ),
                    //SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800]!.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextField(
                                    controller: user,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[800]!.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  obscureText: _isObscure,
                                  controller: pass,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        color: Colors.white,
                                        icon: Icon(_isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        }),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Icon(
                                        Icons.vpn_key,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Container(
                                width: 300,
                                height: 60,
                                child: RaisedButton(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    final response = await http.post(
                                        Uri.parse(
                                            "http://172.20.10.2/veritabani/login.php"),
                                        body: {
                                          'username': user.text,
                                          'password': pass.text,
                                        });
                                    setState(() {
                                      var data = json.decode(response.body);
                                      if (data[0]['rank'] == 'a') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Rutbesiz()));
                                      } else if (data[0]['rank'] == 'ra') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Rutbeli()));
                                      }
                                    });

                                    //Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
