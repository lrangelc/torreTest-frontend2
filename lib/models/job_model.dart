class Job {
  String id;
  String objective;
  String type;

  Job({String id, String objective, String type}) {
    this.id = id;
    this.objective = objective;
    this.type = type;
  }

  Job.fromJson(Map json)
      : id = json['id'],
        objective = json['objective'],
        type = json['type'];

  Map toJson() {
    return {'id': id, 'objective': objective, 'type': type};
  }
}
