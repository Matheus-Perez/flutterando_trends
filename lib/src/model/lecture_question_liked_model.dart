class LectureQuestionLikedModel {
  int idLectureQuestionLiked;
  int idLectureQuestion;
  int idUser;
  String infoDate;

  LectureQuestionLikedModel(
      {this.idLectureQuestionLiked,
      this.idLectureQuestion,
      this.idUser,
      this.infoDate});

  LectureQuestionLikedModel.fromJson(Map<String, dynamic> json) {
    idLectureQuestionLiked = json['id_lecture_question_liked'];
    idLectureQuestion = json['id_lecture_question'];
    idUser = json['id_user'];
    infoDate = json['info_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lecture_question_liked'] = this.idLectureQuestionLiked;
    data['id_lecture_question'] = this.idLectureQuestion;
    data['id_user'] = this.idUser;
    data['info_date'] = this.infoDate;
    return data;
  }
}