import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:khamsat/models/apply.dart';

import '../models/users.dart';
import '../shared_components/colors.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<ProjectApplies> projects = [];

  @override
  void initState() {
    getApplies();
    print(projects.length);
    // TODO: implement initState
    super.initState();
  }

  double rate = 1.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: null,
          body: FutureBuilder(
              future: getApplies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (projects.elementAt(index).idusers.toString() !=
                          widget.user.idusers.toString()) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: const Color(0xff90bafe).withOpacity(00.3),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(14))),
                            child: Column(
                              children: [
                                Column(children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                projects[index].projectName!,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              )
                                            ]),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                                  IconlyBroken.info_circle,
                                                  color: Colors_().primary,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  projects[index]
                                                      .statusName
                                                      .toString() ==
                                                      "null"
                                                      ? 'Pending...'
                                                      : projects[index]
                                                      .statusName
                                                      .toString() ==
                                                      ''
                                                      ? 'Pending'
                                                      : projects[index]
                                                      .statusName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                )
                                              ]),
                                        ),
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
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }


  Future<String> getApplies() async {
    http
        .get(Uri.parse(
        'http://ziadhost123.000webhostapp.com//projectsapplies/read.php'))
        .then((value) {
      String body = value.body;
      print(body);
      ApplyRecords records = ApplyRecords.fromJson(jsonDecode(body));
      setState(() {
        projects = records.records!;
      });
    });
    return 'steve';
  }
}
