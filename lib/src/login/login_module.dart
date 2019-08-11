import 'package:flutterandotrends/src/app_module.dart';
import 'package:flutterandotrends/src/login/login_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/login/login_page.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';

import '../app_bloc.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(AppModule.to.get<HasuraRepository>(),
            AppModule.to.bloc<AppBloc>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
