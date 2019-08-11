import 'package:flutter/material.dart';
import 'package:flutterandotrends/shared/widgets/button_widget.dart';
import 'package:flutterandotrends/src/login/login_bloc.dart';
import 'package:flutterandotrends/src/login/login_module.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _loginBloc = LoginModule.to.bloc<LoginBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[FlutterLogo(), Text('Flutterando Trends')],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _loginBloc.userFormController,
                      decoration: InputDecoration(hintText: 'Usuario'),
                    ),
                    TextField(
                      controller: _loginBloc.passwordFormController,
                      decoration: InputDecoration(hintText: 'Usuario'),
                    ),
                    ButtonWidget(),
                    RaisedButton(
                      onPressed: () {
                        _loginBloc.sendLogin();
                      },
                      child: Text('Loga'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    /*
    Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[FlutterLogo(), Text('Flutterando Trends')],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          color: Colors.pink,
          alignment: Alignment.center,
          child: Container(
            color: Colors.green,
            child: Column(
              mainAxisSize: MainAxisSize.max,              
              children: <Widget>[
                TextField(
                  controller: _loginBloc.userFormController,
                  decoration: InputDecoration(hintText: 'Usuario'),
                ),
                TextField(
                  controller: _loginBloc.passwordFormController,
                  decoration: InputDecoration(hintText: 'Usuario'),
                ),
                InkWell(
                  onTap: null,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('to aqui'),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _loginBloc.sendLogin();
                  },
                  child: Text('Loga'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    */
  }
}
