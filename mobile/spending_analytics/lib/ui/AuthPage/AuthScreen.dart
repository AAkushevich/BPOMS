import 'package:flutter/material.dart';
import 'package:spending_analytics/data/repository/ApiRepository.dart';
import 'package:spending_analytics/data/repository/SharPrefRepositiry.dart';
import 'package:spending_analytics/ui/BasePage/BaseState.dart';

import 'AuthBloc.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends BaseState<LoginPage, AuthBloc> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 50.0),
          _buildLoginForm(),
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(30.0),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 200.0, // has the effect of softening the shadow
            spreadRadius: -80.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
            ),
          )
        ],
//        borderRadius: new BorderRadius.all(...),
//        gradient: new LinearGradient(...),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 400,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 90.0),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: "Email address",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          )),
                    )),
                Container(
                  child: Divider(
                    color: Colors.black,
                  ),
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),
                    )),
                Container(
                    child: Divider(color: Colors.black),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.0)),
                            )
                          ],
                        ))
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  _login();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("Login", style: TextStyle(color: Colors.white)),
                color: Colors.deepPurple,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
      body: _buildPageContent(context),
    );
  }

  @override
  Widget buildStateContent() {
    streamBuilderPrimitive<LOGIN_STATE>(
        bloc.isUserAlreadyAuthStream, LOGIN_STATE.AUTH_REQUIRED, (value) {
      switch (value) {
        case LOGIN_STATE.AUTH_REQUIRED:
          return _buildPageContent(context);
          break;
        case LOGIN_STATE.ALREADY_AUTH:
//Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
          return Container();
          break;
        default:
          return Container();
          break;
      }
    });
  }

  @override
  PreferredSizeWidget buildTopToolbarTitleWidget() {
// TODO: implement buildTopToolbarTitleWidget
    return null;
  }

  @override
  void disposeExtra() {
// TODO: implement disposeExtra
  }

  @override
  void preInitState() {
// TODO: implement preInitState
  }

  @override
  AuthBloc initBloC() {
    return AuthBloc(ApiRepository(), SharedPrefRepository());
  }

  void _login() {
    bloc.login(_emailController.text, _passwordController.text);
  }
}
