import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khamsat/pages/profile.dart';
import 'package:khamsat/pages/requestsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/rate.dart';
import '../models/users.dart';
import '../shared_components/colors.dart';
import 'create_project.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0;
  String rate='',number='';
  @override
  void initState() {
    http
        .get(Uri.parse(
        'http://ziadhost123.000webhostapp.com//users/user_rate.php?idusers=' +
            widget.user.idusers.toString()))
        .then((value) {
      print(value.body);
      RateRecord record = RateRecord.fromJson(jsonDecode(value.body));
      setState(() {
        rate =
            record.records!.elementAt(0).totalRate.toString().substring(0, 3);
        number =
            record.records!.elementAt(0).nbUsersRate.toString();
      });
    });
    print(number);
    print(rate);
    getImage();
    super.initState();
  }

  String image = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (kDebugMode) {}
          return false;
        },
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    elevation: 0,
                    leading: Container(),
                    leadingWidth: 0,
                    title: Column(children: [
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.dashboard_rounded,
                                size: 28, color: Colors.black),
                            Text("  Hello, " + widget.user.fullname.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Colors.black))
                          ])
                    ]),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    actions: const []),
                bottomNavigationBar: SizedBox(
                    height: 60,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 0, right: 0, bottom: 2),
                        child: DefaultTabController(
                            length: 4,
                            child: AppBar(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                shadowColor: Colors.white,
                                elevation: 6,
                                backgroundColor: Colors.white,
                                bottom: TabBar(
                                  onTap: (index) {
                                    setState(() {
                                      selected = index;
                                    });
                                  },
                                  indicatorColor: Colors.blue,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        color: Colors_().primary,
                                        width: 4.0,
                                        style: BorderStyle.solid),
                                    insets: const EdgeInsets.fromLTRB(
                                        35.0, 0.0, 35.0, 53.0),
                                  ),
                                  tabs: [
                                    selected == 0
                                        ? Tab(
                                            icon: Icon(
                                            IconlyBold.home,
                                            color: Colors_().primary,
                                          ))
                                        : const Tab(
                                            icon: Icon(
                                            IconlyLight.home,
                                            color: Colors.grey,
                                          )),selected == 1
                                        ? Tab(
                                            icon: Icon(
                                            Icons.inbox,
                                            color: Colors_().primary,
                                          ))
                                        : const Tab(
                                            icon: Icon(
                                              Icons.inbox,
                                            color: Colors.grey,
                                          )),
                                    selected == 2
                                        ? Tab(
                                            icon: Icon(
                                            IconlyBold.edit,
                                            color: Colors_().primary,
                                          ))
                                        : const Tab(
                                            icon: Icon(
                                            IconlyLight.edit,
                                            color: Colors.grey,
                                          )),
                                    selected == 3
                                        ? Tab(
                                            icon: Icon(
                                            IconlyBold.profile,
                                            color: Colors_().primary,
                                          ))
                                        : const Tab(
                                            icon: Icon(
                                            IconlyBroken.profile,
                                            color: Colors.grey,
                                          )),
                                  ],
                                ))))),
                backgroundColor: const Color(0xfff8fcff),
                body: selected == 0
                    ?  Center(child: Dashboard(user:widget.user))
                    :selected==1?RequestsPage(user:widget.user):

                selected == 2
                        ? Center(
                            child: CreateProject(user: widget.user),
                          )

                            : Builder(
                              builder: (context) {

                                return Profile(
                                    user: widget.user,
                                  rate:rate,
                                  number:number
                                  );
                              }
                            ))));
  }

  storeImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (file != null) {
      prefs.setString('test_image', file.path);
    } else {
      prefs.setString('test_image', 'images/man.jpg');
    }
    setState(() {
      selected = 0;
    });
  }

  getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      image = prefs.getString('test_image')!;
    });
  }
}
