import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl =
    "https://search.torre.co/opportunities/_search/?offset=10&size=100&page=0";

class API {
  static Future<http.Response> getJobs(String minimumSalary, String skills) {
    try {
      String url =
          'https://search.torre.co/opportunities/_search/?offset=0&size=100&page=1';
      String compensationrange = '';
      if (double.parse(minimumSalary) > 0) {
        String maxAmount = (double.parse(minimumSalary) + 2000).toString();
        compensationrange =
            '{"compensationrange":{"minAmount":$minimumSalary,"maxAmount":$maxAmount,"currency":"USD\$","periodicity":"monthly"}}';
      }

      String addSkills = '';
      if (skills.length > 0) {
        List<String> listSkills = skills.split(",");
        listSkills.forEach((element) {
          if (element.length > 0) {
            addSkills +=
                ',{"skill/role":{"text":"${element.trim()}","experience":"potential-to-develop"}}';
          }
        });
      }
      String body = '{"and":[$compensationrange$addSkills]}';

      return http.post(url,
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: body);
    } catch (err) {
      print(err);
    }
    return null;
  }
}
