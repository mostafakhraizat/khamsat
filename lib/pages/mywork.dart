import 'dart:convert';
import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:khamsat/models/projects.dart';
import 'package:http/http.dart' as http;

import '../models/users.dart';
import '../shared_components/colors.dart';
class MyWork extends StatefulWidget {
  const MyWork({Key? key,required this.user,}) : super(key: key);
  final User user;
  @override
  _MyWorkState createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  List<Projects> projects = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(backgroundColor: Colors.white,
            appBar: AppBar(automaticallyImplyLeading: true,
              title: const Text('My Projects'),foregroundColor: Colors.black,backgroundColor: Colors.white,elevation: 0,),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: getProjects(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                    if(snapshot.hasData){
                      return ListView.builder(itemCount: projects.length, itemBuilder: (BuildContext context, int index) {
                        if(projects.elementAt(index).idusers==widget.user.idusers){
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
                                                    IconlyBroken.time_circle,
                                                    color: Colors_().primary,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Text(
                                                    projects[index].projectDate.toString() ==
                                                        "null" ||
                                                        projects[index].projectDate
                                                            .toString() ==
                                                            ""
                                                        ? "not set"
                                                        : projects[index].projectDate.toString(),
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
                        }
                        else{
                          return Container();
                        }
                      },);
                    }else if(projects.isEmpty){
                      return const Center(child: Text('No Projects, create some!'),);
                    }

                    else{
                      return const Center(child:  CircularProgressIndicator.adaptive());
                    }
                  },)
            )));
  }

  Future<String> getProjects()async{
    http.get(Uri.parse('http://ziadhost123.000webhostapp.com//projects/read.php')).then((value) {
      String body = value.body;
      ProjectRecords records = ProjectRecords.fromJson(jsonDecode(body));
      setState(() {
        projects = records.records!;
      });
    });return 'steve';
  }
}
