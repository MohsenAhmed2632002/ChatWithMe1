import 'package:chat3/Pages/Chatpage.dart';
import 'package:chat3/Pages/Regstier_page.dart';
import 'package:chat3/Widgets/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubits/Login_cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  String? email;

  String? password;

  var auth = FirebaseAuth.instance;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginWeating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 2,
              backgroundColor: Color.fromARGB(255, 255, 251, 0),
              content: Text("Weating"),
            ),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 2,
              backgroundColor: Colors.green,
              content: Text("You are logged in"),
            ),
          );
          Future.delayed(
            Duration(seconds: 2),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ChatPage(
                email: email!,
              );
            })),
          );
        } else if (state is LoginFailuer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text("${state.eM}"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/mainicon.png",
                      height: 150,
                      width: 150,
                    ),
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
                          BlocProvider.of<LoginCubit>(context)
                              .loginUser(email: email!, password: password!);
                        }
                      },
                    ), //Rig page
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
      },
    );
  }

  // Future<UserCredential> loginUser() async {
  //   UserCredential user = await auth.signInWithEmailAndPassword(
  //     email: email!,
  //     password: password!,
  //   );
  //   return user;
  // }
}
