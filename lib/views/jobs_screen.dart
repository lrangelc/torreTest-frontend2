import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:torre_test2/models/job_model.dart';
import 'package:torre_test2/net/API.dart';
import 'package:torre_test2/utils/size_config.dart';

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
      appBar: AppBar(
        title: Text("Jobs List"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text('Hi Friend!!!'),
          RaisedButton(
            onPressed: () {},
            color: Theme.of(context).accentColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 5,
                  0, SizeConfig.safeBlockHorizontal * 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    jobs[index].objective,
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
