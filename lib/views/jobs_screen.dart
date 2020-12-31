import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:torre_test2/models/job_model.dart';
import 'package:torre_test2/net/API.dart';
import 'package:torre_test2/net/firebase.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  var jobs = <Job>[];
  TextEditingController _minimumSalary;
  TextEditingController _skill;
  String jobsFound = '';
  bool loading = false;

  String selectedMenuOption;
  List<String> baseMenuOptions = ['Apply'];

  final GlobalKey _menuKey = GlobalKey();

  _getJobs() {
    try {
      setState(() {
        this.loading = true;
      });
      API.getJobs(this._minimumSalary.text, this._skill.text).then((response) {
        setState(() {
          var jsonResponse = convert.jsonDecode(response.body);
          var itemJobs = jsonResponse['results'];
          Iterable list = itemJobs;

          jobs = list.map((model) => Job.fromJson(model)).toList();
          jobs.sort((a, b) => b.minAmount.compareTo(a.minAmount));
          jobsFound = 'Jobs Found: ${jobs.length}';
          this.loading = false;
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
    /// The list containing the [PopUpMenuItem]s
    List<PopupMenuItem> menuOptions = [];

    for (String menuOption in baseMenuOptions) {
      menuOptions.add(new PopupMenuItem(
        child: new Text("$menuOption"),
        value: menuOption,
      ));
    }

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
                hintText: "Add a Skill or more than one, separate by comma",
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
          Text(jobsFound),
          if (loading) CircularProgressIndicator(),
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
                    '${jobs[index].type} 💰 ${jobs[index].currency} ${jobs[index].minAmount} 🤑 ${jobs[index].maxAmount}',
                  ),
                  trailing: new PopupMenuButton(
                    key: GlobalKey(debugLabel: jobs[index].id),
                    onSelected: (selectedDropDownItem) => handlePopUpChanged(
                        selectedDropDownItem,
                        jobs[index].id,
                        jobs[index].objective,
                        jobs[index].type),
                    itemBuilder: (BuildContext context) => menuOptions,
                    tooltip: "Tap me to apply.",
                  ),
                  onTap: () {
                    dynamic popUpMenustate = _menuKey.currentState;
                    if (popUpMenustate != null) {
                      popUpMenustate.showButtonMenu();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// When a [PopUpMenuItem] is selected, we assign its value to
  /// selectedLuckyNumber and rebuild the widget.
  void handlePopUpChanged(
      String value, String jobID, String objective, String type) {
    setState(() {
      selectedMenuOption = value;
    });
    applyJob(jobID, objective, type);

    /// Log the selected lucky number to the console.
    print("The job option you selected was $selectedMenuOption id: $jobID");
  }
}
