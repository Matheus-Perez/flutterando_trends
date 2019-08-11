import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterandotrends/src/app_bloc.dart';
import 'package:flutterandotrends/src/app_module.dart';
import 'package:flutterandotrends/src/model/user_model.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends BlocBase {
  final HasuraRepository _hasuraRepository;
  final _appBloc = AppModule.to.bloc<AppBloc>();
  RegisterBloc(this._hasuraRepository);
  final _userController = BehaviorSubject();
  Observable get outUser => _userController.stream;
  TextEditingController userFormController = TextEditingController();
  TextEditingController nameFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();

  Future<void> sendCreateUser() async {
    final userCreate = UserModel(
      name: nameFormController.text,
      email: userFormController.text,
      password: passwordFormController.text,
    );
    final _userData = await _hasuraRepository.createUser(userCreate);
    _appBloc.inUser.add(_userData);
  }

  @override
  void dispose() {
    _userController.close();
    userFormController.dispose();
    nameFormController.dispose();
    passwordFormController.dispose();
    super.dispose();
  }
}
