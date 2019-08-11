import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/register/register_module.dart';

import 'register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _registerBloc = RegisterModule.to.bloc<RegisterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: _registerBloc.outUser,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _registerBloc.nameFormController,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      errorText: snapshot.error,
                    ),
                  );
                }),
            StreamBuilder(
                stream: _registerBloc.outUser,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _registerBloc.userFormController,
                    decoration: InputDecoration(
                      hintText: 'Usuário',
                      errorText: snapshot.error,
                    ),
                  );
                }),
            StreamBuilder(
                stream: _registerBloc.outUser,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _registerBloc.passwordFormController,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      errorText: snapshot.error,
                    ),
                  );
                }),
            RaisedButton(
              onPressed: () async {
                _registerBloc
                    .sendCreateUser()
                    .then((data) {})
                    .catchError((error) {});
              },
              child: Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }
}
