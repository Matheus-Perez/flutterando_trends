import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/app_module.dart';
import 'package:flutterandotrends/src/home/home_module.dart';
import 'app_bloc.dart';
import 'login/login_module.dart';
import 'model/user_model.dart';
import 'register/register_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = AppModule.to.bloc<AppBloc>();
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<UserModel>(
        stream: appBloc.outUser,
        builder: (context, snapshot) {
          if (snapshot.data?.idUser != null) {
            return HomeModule();
          } else {
            return LoginModule();
          }
        },
      ),
    );
  }
}
