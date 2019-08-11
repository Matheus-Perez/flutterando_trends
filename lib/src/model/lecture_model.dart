class LectureModel {
  int idLecture;
  String presenter;
  String name;
  String description;
  String infoDate;

  LectureModel(
      {this.idLecture,
      this.presenter,
      this.name,
      this.description,
      this.infoDate});

  LectureModel.fromJson(Map<String, dynamic> json) {
    idLecture = json['id_lecture'];
    presenter = json['presenter'];
    name = json['name'];
    description = json['description'];
    infoDate = json['info_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_lecture'] = this.idLecture;
    data['presenter'] = this.presenter;
    data['name'] = this.name;
    data['description'] = this.description;
    data['info_date'] = this.infoDate;
    return data;
  }

  static List<LectureModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => LectureModel.fromJson(item)).toList();
  }

  @override
  String toString() {
    return '${this.toJson()}';
  }
}
