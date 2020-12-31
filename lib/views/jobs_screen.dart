import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:torre_test2/models/job_model.dart';
import 'package:torre_test2/net/API.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  var jobs = <Job>[];
  TextEditingController _minimumSalary;
  TextEditingController _skill;
  String jobsFounded = '';

  _getJobs() {
    try {
      API.getJobs(this._minimumSalary.text, this._skill.text).then((response) {
        setState(() {
          var jsonResponse = convert.jsonDecode(response.body);
          var itemJobs = jsonResponse['results'];
          Iterable list = itemJobs;

          jobs = list.map((model) => Job.fromJson(model)).toList();
          jobsFounded = 'Jobs founded: ${jobs.length}';
        });
      });
    } catch (err) {
      print(err);
    }
  }

  initState() {
    super.initState();
    _minimumSalary = TextEditingController();
    _skill = TextEditingController();
    _minimumSalary.text = '1000';
    _skill.text = '';
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs List"),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff8c52ff),
      ),
      body: Column(
        children: [
          Text('Minimum Salary:'),
          Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _minimumSalary,
              decoration: const InputDecoration(
                hintText: "Enter Minimun Salary",
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Skills:'),
          Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _skill,
              decoration: const InputDecoration(
                hintText: "Add a Skill",
              ),
            ),
          ),
          Center(
            child: ButtonBar(
              mainAxisSize: MainAxisSize
                  .min, // this will take space as minimum as posible(to center)
              children: <Widget>[
                RaisedButton(
                  child: Text('Search'),
                  onPressed: () {
                    _getJobs();
                  },
                ),
              ],
            ),
          ),
          Text(jobsFounded),
          SizedBox(
            height: 20,
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${jobs[index].objective}',
                  ),
                  subtitle: Text(
                    '${jobs[index].type}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
