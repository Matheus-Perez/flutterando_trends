import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutterandotrends/shared/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import 'repository/hasura_repository.dart';

class AppBloc extends BlocBase {
  final HasuraRepository hasuraRepository;
  AppBloc(this.hasuraRepository);

  final _userController = BehaviorSubject<UserModel>();
  Observable<UserModel> get outUser => _userController.stream;
  Sink<UserModel> get inUser => _userController.sink;
  UserModel get userControleValue =>_userController.value;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
}
