import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutterandotrends/shared/models/lecture_model.dart';
import 'package:flutterandotrends/src/repository/hasura_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final HasuraRepository _hasuraRepository;
  StreamSubscription lecturesFlux;
  HomeBloc(this._hasuraRepository) {
    lecturesFlux =
        _hasuraRepository.getLectures().listen(_lecturesController.add);
  }
  final _lecturesController = BehaviorSubject<List<LectureModel>>();
  Observable<List<LectureModel>> get outLectures => _lecturesController.stream;
  Sink<List<LectureModel>> get inLectures => _lecturesController.sink;

  sendGetLectures() {}

  @override
  void dispose() {
    lecturesFlux.cancel();
    _lecturesController.close();
    super.dispose();
  }
}
