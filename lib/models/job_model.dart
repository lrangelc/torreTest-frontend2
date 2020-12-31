class Job {
  String id;
  String objective;
  String type;
  String currency;
  double minAmount;
  double maxAmount;

  Job(
      {String id,
      String objective,
      String type,
      String currency,
      double minAmount,
      double maxAmount}) {
    this.id = id;
    this.objective = objective;
    this.type = type;
    this.currency = currency;
    this.minAmount = minAmount;
    this.maxAmount = maxAmount;
  }

  Job.fromJson(Map json) {
    try {
      id = json['id'];
      objective = json['objective'];
      type = json['type'];
      currency = '?';
      minAmount = 0;
      maxAmount = 0;

      var compensation = json['compensation'];
      if (compensation != null) {
        var data = compensation['data'];
        if (data != null) {
          currency = data['currency'];
          minAmount = data['minAmount'] ?? 0;
          maxAmount = data['maxAmount'] ?? 0;
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Map toJson() {
    return {
      'id': id,
      'objective': objective,
      'type': type,
      'currency': currency,
      'minAmount': minAmount,
      'maxAmount': maxAmount
    };
  }
}
