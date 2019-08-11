import 'package:flutterandotrends/src/register/register_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/register/register_page.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';

import '../app_module.dart';

class RegisterModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegisterBloc(AppModule.to.get<HasuraRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterPage();

  static Inject get to => Inject<RegisterModule>.of();
}
