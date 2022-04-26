import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/users.dart';
import '../shared_components/colors.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final _gender = [
    "Full Time",
    "Freelance",
  ];

  final TextEditingController name = TextEditingController();
  final TextEditingController specialization = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController max = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    print(widget.user.idusers);
    getspecs();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    specialization.dispose();
    date.dispose();
    type.dispose();
    price.dispose();
    max.dispose();
    description.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  bool loading = false;
  GlobalKey<FormState> key = GlobalKey();

  final GlobalKey<FormState> _key = GlobalKey();
  int textLength = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Create project',
                      style: TextStyle(
                          fontSize: 22,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Field Required';
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                      prefixIcon: const Icon(Icons.drive_file_rename_outline),
                      enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "Project Name",
                    )),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Field Required';
                            } else {
                              return null;
                            }
                          },
                          readOnly: true,
                          onTap: () async {
                            await _selectDate(context);
                            date.text =
                                "${selectedDate.toLocal()}".split(' ')[0];
                          },
                          controller: date,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                            prefixIcon: const Icon(Icons.date_range),
                            enabledBorder: const OutlineInputBorder(

                                // width: 0.0 produces a thin "hairline" border

                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: "Date",
                          )),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Field Required';
                            } else {
                              return null;
                            }
                          },
                          readOnly: true,
                          controller: type,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                type.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return _gender
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem(
                                      child: Text(value), value: value);
                                }).toList();
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                            prefixIcon: const Icon(Icons.category),
                            enabledBorder: const OutlineInputBorder(

                                // width: 0.0 produces a thin "hairline" border

                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: "Type",
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Field Required';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: price,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                            prefixIcon: const Icon(Icons.price_check),
                            enabledBorder: const OutlineInputBorder(

                                // width: 0.0 produces a thin "hairline" border

                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: "Price",
                          )),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Field Required';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: max,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                            prefixIcon:
                                const Icon(Icons.supervised_user_circle_sharp),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            hintText: "Max Users",
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Field Required';
                      } else {
                        return null;
                      }
                    },
                    controller: description,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                      prefixIcon: const Icon(Icons.info),
                      enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "Description",
                    )),
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Field Required';
                      } else {
                        return null;
                      }
                    },
                    controller: specialization,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffc0c0c0).withOpacity(0.2),
                      prefixIcon: const Icon(Icons.info),
                      enabledBorder: const OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: "Specialization",
                    )),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, right: 25, left: 25),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors_().primary1,
                      Colors_().primary,
                    ]),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: InkWell(
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          String projectName = name.text,
                              projectDescription = description.text,
                              maxUsers = max.text,
                              projectPrice = price.text,
                              projectDate = date.text,
                              projectType = type.text,
                              projectspec = specialization.text;

                          http
                              .get(Uri.parse(
                                  'http://ziadhost123.000webhostapp.com//projects/create.php?project_name=' +
                                      projectName +
                                      '&project_description=' +
                                      projectDescription +
                                      '&max_nb_users=' +
                                      maxUsers +
                                      '&price=' +
                                      projectPrice +
                                      '&idspecialization=' +
                                      specialization.text.toString() +
                                      '&idusers=' +
                                      widget.user.idusers.toString() +
                                      '&project_date=' +
                                      projectDate +
                                      '&project_type_work=' +
                                      projectType))
                              .then((value) {
                            print(value.statusCode.toString());
                            if (value.body.contains('Error')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Error, please try again')));
                            } else {
                              setState(() {
                                loading=false;
                                name.clear();
                                description.clear();
                                max.clear();
                                price.clear();
                                date.clear();
                                type.clear();
                                specialization.clear();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Success')));
                            }
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: !loading
                            ? const Text(
                                "Complete your Creation",
                                style: TextStyle(
                                    fontFamily: 'Mulish', color: Colors.white),
                              )
                            : const CircularProgressIndicator(),
                      )),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Future<List<String>?>? getspecs() {
    http.get(Uri.parse('uri')).then((value) {
      setState(() {});
    });
    return null;
  }
}
