import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:torre_test2/theme/routes.dart';
import 'package:torre_test2/views/profile_screen.dart';
import 'package:torre_test2/views/video_screen.dart';
import 'package:torre_test2/views/test_screen.dart';
import 'package:torre_test2/views/jobs_screen.dart';

import 'article_screen.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen();
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  MenuScreenState();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        } else {
          print('User is signed in!');
        }
      });
    } catch (err) {
      print(err.message);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 5,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.search_rounded),
                    ),
                    Tab(
                      icon: Icon(Icons.video_library),
                    ),
                    Tab(
                      icon: Icon(Icons.insert_drive_file),
                    ),
                    Tab(
                      icon: Icon(Icons.article),
                    ),
                    Tab(
                      icon: Icon(Icons.account_circle),
                    ),
                  ],
                  labelColor: Color(
                    0xff8c52ff,
                  ),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xff8c52ff),
                      width: 4.0,
                    ),
                    insets: EdgeInsets.only(
                      bottom: 44,
                    ),
                  ),
                  unselectedLabelColor: Colors.grey,
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  JobsScreen(),
                  VideoScreen(),
                  TestScreen(),
                  ArticleScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
