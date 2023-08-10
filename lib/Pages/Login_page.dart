import 'package:chat3/Pages/Chatpage.dart';
import 'package:chat3/Pages/Regstier_page.dart';
import 'package:chat3/Widgets/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  var auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/mainicon.png"),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                LoginFormField(
                    onChange: (p0) {
                      email = p0;
                      print("log email :  $email");
                    },
                    lable: "Enter email: ",
                    icon: Icons.email_outlined),
                SizedBox(
                  height: 30,
                ),
                LoginFormField(
                  onChange: (p1) {
                    password = p1;
                    print("log   pass: $password");
                  },
                  lable: "Enter pass: ",
                  icon: Icons.password_sharp,
                ),
                SizedBox(
                  height: 30,
                ),
                LoginButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        UserCredential user = await loginUser();
                        snakBarwhensucc(context, user);
                        Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatPage(
                              email: email!,
                            );
                          })),
                        );
                      } on FirebaseAuthException catch (e) {
                        returnEx(e, context);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I waana careate acc    ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage();
                          },
                        ));
                      },
                      child: Text(
                        "Register...",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void returnEx(FirebaseAuthException e, BuildContext context) {
    print('Failed with error code: ${e.code}');
    print(e.message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("${e.message}"),
      ),
    );
  }

  void snakBarwhensucc(BuildContext context, UserCredential user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 2,
        backgroundColor: Colors.green,
        content: Text("You created       by:${user.user?.email}"),
      ),
    );
  }

  Future<UserCredential> loginUser() async {
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return user;
  }
}
