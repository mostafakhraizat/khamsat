import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khamsat/config/routing.dart';
import 'package:khamsat/logins/register.dart';
import 'package:khamsat/models/users.dart';
import 'package:khamsat/pages/homepage.dart';
import 'package:khamsat/shared_components/colors.dart';
import 'package:khamsat/shared_components/style.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/assets_paths.dart';



class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  int textLength = 0;
  final GlobalKey<FormState> _key = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget button = Text('Login', style: MyStyles().buttonText);
  bool loading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (kDebugMode) {
            print("asd");
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.4,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: const Image(image: AssetImage(AssetPath.login_image)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            const SizedBox(width: 18),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Welcome Back!",
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge),
                                const SizedBox(height: 16),
                                Text("Login",
                                    style:
                                    Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: usernameController,
                                onChanged: (value) {
                                  setState(() {
                                    textLength = value.length;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Username';
                                  }
                                  return null;
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
                                  hintText: 'Email',
                                  hintStyle: MyStyles().hintText,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                onSaved: (String? value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              child: TextFormField(
                                  textInputAction: TextInputAction.send,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  obscureText: _obscureText,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: MyStyles().hintText,
                                    hintText: 'Password',
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 10.0, 20.0, 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        semanticLabel: _obscureText
                                            ? 'show password'
                                            : 'hide password',
                                      ),
                                    ),
                                  ),
                                  onSaved: (String? value) {}),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30),
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      _key.currentState!.save();
                                      setState(() {
                                        loading = true;
                                      });
                                      final prefs =
                                      await SharedPreferences.getInstance();
                                      String username = usernameController.text;
                                      String password = passwordController.text;
                                      Map<String, String> queryParams = {
                                        "username": username,
                                        "password": password
                                      };
                                      String queryString =
                                          Uri(queryParameters: queryParams)
                                              .query;
                                      try {
                                        http.get(
                                            Uri.parse(
                                                'http://ziadhost123.000webhostapp.com/users/login.php?email='+username +'&password='+password),
                                            headers: {
                                              'Content-Type': 'application/json'
                                            }).then((value) {
                                          setState(() {
                                            loading = false;
                                          });
                                          if (value.body.contains('error')||value.body.contains('Error')) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'wrong email or password')));
                                          } else {
                                            Records records = Records.fromJson(
                                                jsonDecode(value.body));
                                            print(value.body);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        HomePage(user: records
                                                            .records!.elementAt(
                                                            0))));
                                          }
                                        }).onError((error, stackTrace) {
                                          setState(() {
                                            loading = false;
                                            print(error);
                                          });
                                        });
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    }
                                  },
                                  child: loading
                                      ? GlowingProgressIndicator(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text("Loading",
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          JumpingDotsProgressIndicator(
                                            fontSize: 14,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Text('Login',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleSmall),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors_().primary,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 80,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                    Routing().createRoute(RegisterPage()));
                              },
                              child: Text("Create Account?",
                                  style: MyStyles().normalGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
