import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/users.dart';
import '../shared_components/colors.dart';
import '../shared_components/style.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  int textLength = 0;
  TextEditingController controller = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController fullName = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('My Info'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Edit CV File',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      content: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            textLength = value.length;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: textLength > 0
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors_().primary,
                                )
                              : const Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                ),
                          hintText: 'CV Link',
                          hintStyle: MyStyles().hintText,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.grey[900]!, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            updateCV(controller.text);
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        )
                      ],
                      semanticLabel: 'asda',
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
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
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 16, bottom: 16),
                              child: Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'CV File',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.user.cvFile.toString() == 'null'
                                          ? controller.text
                                          : widget.user.cvFile.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
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
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
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
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 16, bottom: 16),
                            child: Builder(builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Username',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget.user.username!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
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
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Edit Phone',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      content: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: phone,
                        onChanged: (value) {
                          setState(() {
                            textLength = value.length;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: textLength > 0
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors_().primary,
                                )
                              : const Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                ),
                          hintText: 'Phone',
                          hintStyle: MyStyles().hintText,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.grey[900]!, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            updatePhone(phone.text);
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        )
                      ],
                      semanticLabel: 'asda',
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
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
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 16, bottom: 16),
                              child: Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.user.phoneNumber.toString() == ''
                                          ? phone.text
                                          : widget.user.phoneNumber.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
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
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Full Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      content: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: fullName,
                        onChanged: (value) {
                          setState(() {
                            textLength = value.length;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: textLength > 0
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors_().primary,
                                )
                              : const Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                ),
                          hintText: 'Full Name',
                          hintStyle: MyStyles().hintText,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.grey[900]!, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            updateName(fullName.text);
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        )
                      ],
                      semanticLabel: 'asda',
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
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
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 16, bottom: 16),
                              child: Builder(builder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Full name',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.user.fullname!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
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
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
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
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 16, bottom: 16),
                            child: Builder(builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Username',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget.user.email!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
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
            ),
          ],
        ),
      ),
    ));
  }

  updateCV(cd_file) {
    http
        .get(Uri.parse(
            'http://ziadhost123.000webhostapp.com//users/update.php?idusers=' +
                widget.user.idusers.toString() +
                '&fullname=' +
                widget.user.fullname.toString() +
                '&username=' +
                widget.user.username.toString() +
                '&email=' +
                widget.user.email.toString() +
                '&password=' +
                widget.user.password.toString() +
                '&idcompany=' +
                widget.user.idcompany.toString() +
                "&cv_file=" +
                cd_file +
                "&profile_image=a"))
        .then((value) {});
  }

  updateName(cd_file) {
    http
        .get(Uri.parse(
            'http://ziadhost123.000webhostapp.com//users/update.php?idusers=' +
                widget.user.idusers.toString() +
                '&fullname=' +
                cd_file +
                '&username=' +
                widget.user.username.toString() +
                '&email=' +
                widget.user.email.toString() +
                '&password=' +
                widget.user.password.toString() +
                '&idcompany=' +
                widget.user.idcompany.toString() +
                "&cv_file=" +
                widget.user.cvFile.toString() +
                "&profile_image=a&phone_number="+widget.user.phoneNumber.toString()))
        .then((value) {});
  }

  updatePhone(cd_file) {
    http
        .get(Uri.parse(
            'http://ziadhost123.000webhostapp.com//users/update.php?idusers=' +
                widget.user.idusers.toString() +
                '&fullname=' +
                widget.user.fullname.toString() +
                '&username=' +
                widget.user.username.toString() +
                '&email=' +
                widget.user.email.toString() +
                '&password=' +
                widget.user.password.toString() +
                '&idcompany=' +
                widget.user.idcompany.toString() +
                "&cv_file=" +
                cd_file +
                "&profile_image=a&phone_number=" +
                cd_file))
        .then((value) {});
  }
}
