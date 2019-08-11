import 'package:flutterandotrends/src/repository/hasura_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/app_widget.dart';
import 'package:flutterandotrends/src/app_bloc.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc(i.get<HasuraRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HasuraRepository(i.get<HasuraConnect>())),
        Dependency(
          (i) => HasuraConnect(
              'https://flutterando-trends.herokuapp.com/v1/graphql',
              headers: {'x-hasura-admin-secret':'flutterando@2019'}),
        ),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
