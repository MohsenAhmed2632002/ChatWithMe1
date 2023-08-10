import 'package:chat3/Pages/Chatpage.dart';
import 'package:chat3/Pages/Login_page.dart';
import 'package:chat3/Widgets/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;
  var auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/mainicon.png",
                ),
                Text(
                  "Register",
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
                    if (formKey.currentState!.validate()) {
                      try {
                        UserCredential user = await registerUser();

                        snakBarwhensucc(context, user);
                        savepref(email: email!);
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
                      "I  Have acc    ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text(
                        "Login...",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  savepref({required String email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("email", email);
    });
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
        content: Text("You Registered by:${user.user?.email}"),
      ),
    );
  }

  Future<UserCredential> registerUser() async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return user;
  }
}
