class QuizModel {
    int code;
    int id;
    int test;
    String title;
    int strongId;
    int quizId;

    int get _id => id;
    int get _test => test;
    int get _code => code;
    String get _title => title;
    int get _quizId => quizId;

    void setId(int id) {
        this.id = id;
    }

    QuizModel({this.code, this.id, this.test, this.title, this.strongId, this.quizId});

    factory QuizModel.fromJson(Map<String, dynamic> json) {
        return QuizModel(
            code: json['code'],
            test: json['test'], 
            title: json['title'],
            strongId: json['strong_id'],
            quizId: json['quiz_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['test'] = this.test;
        data['title'] = this.title;
        data['strong_id'] = this.strongId;
        data['quiz_id'] = this.quizId;
        return data;
    }
}