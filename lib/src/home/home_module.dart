import 'package:flutterandotrends/src/app_module.dart';
import 'package:flutterandotrends/src/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/home/home_page.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(AppModule.to.getDependency<HasuraRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
