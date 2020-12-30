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

  _getJobs() {
    try {
      API.getJobs().then((response) {
        setState(() {
          var jsonResponse = convert.jsonDecode(response.body);
          var itemJobs = jsonResponse['results'];
          Iterable list = itemJobs;

          jobs = list.map((model) => Job.fromJson(model)).toList();
        });
      });
    } catch (err) {
      print(err);
    }
  }

  initState() {
    super.initState();
    _getJobs();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Jobs List"),
      // ),
      body: Column(
        children: [
          Text('Hi Friend!!!'),
          ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  jobs[index].objective,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
