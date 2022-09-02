import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bramblur/components/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  late User user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;

    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    log(user.toString());

    super.initState();
  }

  /// Map User provider data into a list of Provider Ids.
  List get userProviders => user.providerData.map((e) => e.providerId).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 5,
            child: GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: Scaffold(
                  backgroundColor: Colors.redAccent,
                  appBar: AppBar(
                      bottom: const TabBar(tabs: [
                    Tab(icon: Icon(Icons.account_circle_rounded)),
                    Tab(icon: Icon(Icons.home_rounded)),
                    Tab(icon: Icon(Icons.add_box_rounded)),
                    Tab(icon: Icon(Icons.bookmark_border_rounded)),
                    Tab(icon: Icon(Icons.calendar_month_rounded)),
                  ])),
                  body: const TabBarView(
                    children: [
                      Icon(Icons.account_circle_rounded),
                      Icon(Icons.account_circle_rounded),
                      Icon(Icons.account_circle_rounded),
                      Icon(Icons.account_circle_rounded),
                      Icon(Icons.account_circle_rounded),
                    ],
                  ),
                ))));
  }
}
