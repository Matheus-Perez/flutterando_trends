import 'package:flutter/material.dart';
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
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
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
            RaisedButton(
              onPressed: () {
                _loginBloc.sendLogin();
              },
              child: Text('Loga'),
            )
          ],
        ),
      ),
    );
  }
}
