import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:khamsat/models/projects.dart';

import '../models/users.dart';
import '../shared_components/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Projects> projects = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Recommended Projects'),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: getProjects(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: projects.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (projects.elementAt(index).idusers.toString() !=
                              widget.user.idusers) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                decoration: BoxDecoration(
                                    color: const Color(0xff90bafe)
                                        .withOpacity(00.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14))),
                                child: Column(
                                  children: [
                                    Column(children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    IconlyBroken.activity,
                                                    color: Colors_().primary,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Text(
                                                    projects[index]
                                                        .projectName!,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ]),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Apply for ' +
                                                                projects[index]
                                                                    .projectName
                                                                    .toString() +
                                                                "?"),
                                                        content: const Text(
                                                            'Are you sure you want to add this project to your work list?'),
                                                        actions: [
                                                          InkWell(
                                                            child:
                                                                const Text('Cancel'),
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            width: 22,
                                                          ),
                                                          InkWell(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(12.0),
                                                              child: const Text(
                                                                'Apply',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              String url = 'http://ziadhost123.000webhostapp.com/projectsapplies/create.php?idprojects=' +
                                                                  projects[
                                                                          index]
                                                                      .idprojects
                                                                      .toString() +
                                                                  '&idusers=' +
                                                                  widget.user
                                                                      .idusers
                                                                      .toString() +
                                                                  '&user_rate=1';

                                                              http
                                                                  .get(
                                                                      Uri.parse(
                                                                          url))
                                                                  .then(
                                                                      (value) {
                                                                print(
                                                                    value.body);
                                                                print(value
                                                                    .statusCode);
                                                                if (value.body
                                                                    .contains(
                                                                        'Error')) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Error, please try again')));
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text('Applied, show in next tab')));
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                        actionsPadding:
                                                            const EdgeInsets.all(22),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: const [
                                                      SizedBox(
                                                        width: 22,
                                                      ),
                                                      Text(
                                                        'Apply',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(
                                                        width: 22,
                                                      )
                                                    ],
                                                  ),
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors_().primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 24,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      IconlyBroken.category,
                                                      color: Colors_().primary,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      projects[index].price!,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  ]),
                                            )
                                          ]),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      IconlyBroken.time_circle,
                                                      color: Colors_().primary,
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      projects[index]
                                                                      .projectDate
                                                                      .toString() ==
                                                                  "null" ||
                                                              projects[index]
                                                                      .projectDate
                                                                      .toString() ==
                                                                  ""
                                                          ? "not set"
                                                          : projects[index]
                                                              .projectDate
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  ]),
                                            )
                                          ])
                                    ]),
                                    const SizedBox(
                                      height: 24,
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                  },
                ))));
  }

  Future<String> getProjects() async {
    http
        .get(Uri.parse(
            'http://ziadhost123.000webhostapp.com/projects/read.php'))
        .then((value) {
      String body = value.body;
      ProjectRecords records = ProjectRecords.fromJson(jsonDecode(body));
      setState(() {
        projects = records.records!;
      });
    });
    return 'steve';
  }
}
