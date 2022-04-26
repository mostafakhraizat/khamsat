import 'dart:convert';
import 'dart:io';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:khamsat/config/routing.dart';
import 'package:khamsat/logins/login_page.dart';
import 'package:khamsat/models/rate.dart';
import 'package:khamsat/pages/my_info.dart';
import 'package:khamsat/pages/my_projects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users.dart';
import 'mywork.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.user, this.rate, this.number}) : super(key: key);
  final User user;
  final rate,number;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String rate = '';
  String number = '';
  String image = '';

  @override
  void initState() {
    getRate();
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username = widget.user.username!;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 25, 40, 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        image = prefs.getString('test_image')!;
                      });
                      print(image);
                    },
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Information',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Hero(
                              tag: 'tag',
                              child: InkWell(
                                onTap: () {
                                  storeImage();
                                  getImage();
                                },
                                child: Builder(builder: (context) {
                                  return CircleAvatar(
                                      radius: 32,
                                      foregroundImage: FileImage(File(image)));
                                }),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 22, top: 16, bottom: 16),
                              child: Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Builder(builder: (context) {
                                      return Text(
                                        username,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      );
                                    }),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      username,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                );
                              }))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Container(
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Icon(Icons.star),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.amber,
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 22, top: 16, bottom: 16),
                              child: Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder(
                                      future:getRate(),
                                      builder: (cont,ext) {
                                        return Row(
                                          children: [
                                            RatingBar.builder(
                                              initialRating: widget.rate=='nul'?1:double.parse(widget.rate),
                                              minRating: 1,
                                              direction:
                                              Axis.horizontal,
                                              allowHalfRating: true,
                                              unratedColor: Colors
                                                  .amber
                                                  .withAlpha(50),
                                              itemCount: 5,
                                              itemSize: 15.0,
                                              itemPadding:const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  4.0),
                                              itemBuilder:
                                                  (context, _) =>
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                              onRatingUpdate:
                                                  (rating) {
                                              },ignoreGestures: true,
                                              updateOnDrag: false,
                                            ),
                                            Text('('+number+')')
                                          ],
                                        );
                                      }
                                    )
                                  ],
                                );
                              }))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          Routing().createRoute(MyInfo(user: widget.user)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Icon(Icons.info),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.indigo.withOpacity(0.2),
                                  ),
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(Routing()
                                    .createRoute(MyInfo(user: widget.user)));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, top: 16, bottom: 16),
                                  child: FutureBuilder(
                                      builder: (context, snapshot) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'My Info',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    );
                                  })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          Routing().createRoute(MyProjects(user: widget.user)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Icon(Icons.category),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.indigo.withOpacity(0.2),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 22, top: 16, bottom: 16),
                                child: Builder(builder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'My Projects',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  );
                                }))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (c) => LoginPage()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: const [
                            Expanded(child: Text('Sign out')),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  storeImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (file != null) {
      prefs.setString('test_image', file.path);
    } else {
      prefs.setString('test_image', 'images/man.jpg');
    }
  }

  getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      image = prefs.getString('test_image')!;
    });
  }

  Future<double> getRate() async {

    http
        .get(Uri.parse(
            'http://ziadhost123.000webhostapp.com//users/user_rate.php?idusers=' +
                widget.user.idusers.toString()))
        .then((value) {
          print(value.body);
      RateRecord record = RateRecord.fromJson(jsonDecode(value.body));
      print(record.records!.elementAt(0).nbUsersRate.toString());
      setState(() {
        number =
            record.records!.elementAt(0).nbUsersRate.toString();
      });
    });
    return 1.0;
  }
}
