import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterandotrends/src/app_bloc.dart';
import 'package:flutterandotrends/src/model/user_model.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';

class LoginBloc extends BlocBase {
  final HasuraRepository _hasuraRepository;
  final AppBloc _appBloc;
  LoginBloc(this._hasuraRepository, this._appBloc);
  TextEditingController userFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();
  sendLogin() async {
    final _userCreate = UserModel(
        email: userFormController.text, password: passwordFormController.text);
    final _userResponse = await _hasuraRepository.getUser(_userCreate);
    if (_userResponse != null) {
      _appBloc.inUser.add(_userResponse);
      print(_appBloc.userControleValue);
    }
  }

  @override
  void dispose() {
    passwordFormController.dispose();
    userFormController.dispose();
    super.dispose();
  }
}
