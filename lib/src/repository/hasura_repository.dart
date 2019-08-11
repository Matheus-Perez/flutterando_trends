import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutterandotrends/src/model/lecture_model.dart';
import 'package:flutterandotrends/src/model/lecture_question_liked_model.dart';
import 'package:flutterandotrends/src/model/lecture_question_model.dart';
import 'package:flutterandotrends/src/model/user_model.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HasuraRepository extends Disposable {
  final HasuraConnect conn;

  HasuraRepository(this.conn);

  Future<UserModel> getUser(UserModel user) async {
    String query = '''getUser(\$email:String!, \$pwd:String!){
                        user(where: {email: {_eq: \$email}, password: {_eq: \$pwd}}) {
                          id_user
                          name
                          email
                          info_date
                        }
                      }''';

    try {
      var data = await conn
          .query(query, variables: {'email': user.email, 'pwd': user.password});
      // TODO  Verifica se dados do usuario existe
      if (data['data']['user'].isEmpty) {
        throw 'Usuario ou senha invalidos';
      } else {
        return UserModel.fromJson(data['data']['user'][0]);
      }
    } catch (e) {
      print('LOGX ==:>> ERROR[getUser]');
      print(e);
      print('=================');
      return null;
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    var query =
        '''mutation createUser(\$name:String!, \$email:String!, \$pwd:String!){
                    insert_user(objects: {name: \$name, email: \$email, password: \$pwd}) {
                      returning {
                        id_user
                        info_date
                      }
                    }
                  }''';

    try {
      var data = await conn.mutation(query, variables: {
        'name': user.name,
        'email': user.email,
        'pwd': user.password
      });

      user.idUser = data['data']['insert_user']['returning'][0]['id_user'];
      user.infoDate = data['data']['insert_user']['returning'][0]['info_date'];
      return user;
    } catch (e) {
      print('LOGX ==:>> ERROR[createUser]');
      print(e);
      print('=================');
      return null;
    }
  }

  Future<LectureQuestionModel> createLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    var query =
        '''mutation createLectureQuestion(\$id_lecture:Int!, \$id_user:Int!, \$description:String!){
                      insert_lecture_question(objects: {id_lecture: \$id_lecture, id_user:  \$id_user, description: \$description}) {
                        returning {
                          id_lecture_question
                          info_date
                        }
                      }
                    }''';
    try {
      var data = await conn.mutation(query, variables: {
        'id_lecture': lectureQuestion.idLecture,
        'id_user': lectureQuestion.idUser,
        'description': lectureQuestion.description
      });

      lectureQuestion.idLectureQuestion = data['data']
          ['insert_lecture_question']['returning'][0]['id_lecture_question'];
      lectureQuestion.infoDate =
          data['data']['insert_lecture_question']['returning'][0]['info_date'];
      return lectureQuestion;
    } catch (e) {
      print('LOGX ==:>> ERROR[createLectureQuestion]');
      print(e);
      print('=================');
      return null;
    }
  }

  Future<bool> deleteLectureQuestion(
      LectureQuestionModel lectureQuestion) async {
    var query = '''mutation deleteLectureQuestion(\$id_lecture_question:Int!){
                    delete_lecture_question(where: {id_lecture_question: {_eq: \$id_lecture_question}}) {
                      affected_rows
                    }
                  }''';
    try {
      await conn.mutation(
        query,
        variables: {'id_lecture_question': lectureQuestion.idLectureQuestion},
      );
      return true;
    } catch (e) {
      print('LOGX ==:>> ERROR[deleteLectureQuestion]');
      print(e);
      print('=================');
      return false;
    }
  }

  Future<bool> createLectureQuestionLiked(
      LectureQuestionLikedModel lectureQuestionLiked) async {
    var query =
        '''mutation createLiked(\$id_lecture_question:Int!, \$id_user:Int!){
                      insert_lecture_question_liked(objects: {id_lecture_question: \$id_lecture_question, id_user: \$id_user}) {
                        affected_rows
                      }
                    }''';
    try {
      await conn.mutation(
        query,
        variables: {
          'id_lecture_question': lectureQuestionLiked.idLectureQuestion,
          'id_user': lectureQuestionLiked.idUser,
        },
      );
      return true;
    } catch (e) {
      print('LOGX ==:>> ERROR[createLiked]');
      print(e);
      print('=================');
      return false;
    }
  }

  Future<bool> deleteLectureQuestionLiked(
      LectureQuestionLikedModel lectureQuestionLiked) async {
    var query =
        '''mutation deleteLectureQuestionLiked(\$id_lecture_question_liked:Int!){
            delete_lecture_question_liked(where: {id_lecture_question_liked: {_eq: \$id_lecture_question_liked}}) {
              affected_rows
            }
          }''';

    try {
      await conn.mutation(
        query,
        variables: {
          'id_lecture_question_liked':
              lectureQuestionLiked.idLectureQuestionLiked,
        },
      );
      return true;
    } catch (e) {
      print('LOGX ==:>> ERROR[deleteLectureQuestionLiked]');
      print(e);
      print('=================');
      return false;
    }
  }

  Stream<List<LectureModel>> getLectures() {
    var query = '''subscription {
                    lecture {
                      id_lecture
                      presenter
                      name
                      description
                      info_date
                    }
                  }''';
    try {
      Snapshot snapshot = conn.subscription(query);
      return snapshot.stream.map(
        (json) => LectureModel.fromJsonList(json['data']['lecture']),
      );
    } catch (e) {
      print('LOGX ==:>> ERROR[getLectures]');
      print(e);
      print('=================');
      return null;
    }
  }

  Stream<List<LectureQuestionModel>> getQuestionLectures(
      {@required LectureModel lecture, @required UserModel user}) {
    var query =
        '''subscription getQuestionLectures(\$id_lecture:Int!, \$id_user:Int!){
                    lecture_question(where: {id_lecture: {_eq: \$id_lecture}}, order_by: {lecture_question_liked_aggregate: {count: desc}}) {
                      id_lecture_question
                      id_lecture
                      description
                      info_date
                      user {
                        id_user
                        name
                      }
                      lecture_question_liked_aggregate {
                        aggregate {
                          count
                        }
                      }
                      lecture_question_liked(where: {id_user: {_eq: \$id_user}}) {
                        id_lecture_question_liked
                      }
                    }
                  }''';
    try {
      Snapshot snapshot = conn.subscription(query, variables: {
        'id_lecture': lecture.idLecture,
        'id_user': user.idUser,
      });
      return snapshot.stream.map(
        (json) =>
            LectureQuestionModel.fromJsonList(json['data']['lecture_question']),
      );
    } catch (e) {
      print('LOGX ==:>> ERROR[getQuestionLectures]');
      print(e);
      print('=================');
      return null;
    }
  }

  @override
  void dispose() {
    conn.dispose();
  }
}
