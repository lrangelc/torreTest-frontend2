class Skill {
  String name;
  String experience;

  Skill({
    String name,
    String experience,
  }) {
    this.name = name;
    this.experience = experience;
  }

  Skill.fromJson(Map json) {
    try {
      name = json['name'];
      experience = json['experience'];
    } catch (err) {
      print(err);
    }
  }

  Map toJson() {
    return {
      'name': name,
      'experience': experience,
    };
  }
}
