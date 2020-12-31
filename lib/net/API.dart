import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl =
    "https://search.torre.co/opportunities/_search/?offset=10&size=100&page=0";

class API {
  static Future getJobs(String minimumSalary, String skill) {
    String maxAmount = (double.parse(minimumSalary) + 2000).toString();
    String url =
        'https://search.torre.co/opportunities/_search/?offset=0&size=100&page=1';
    String compensationrange =
        '{"compensationrange":{"minAmount":$minimumSalary,"maxAmount":$maxAmount,"currency":"USD\$","periodicity":"monthly"}}';

    String addSkill = '';
    if (skill.length > 0) {
      addSkill =
          ',{"skill/role":{"text":"$skill","experience":"potential-to-develop"}}';
    }
    String body = '{"and":[$compensationrange$addSkill]}';

    return http.post(url,
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: body);
  }
}
