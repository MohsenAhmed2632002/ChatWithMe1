import 'package:chat3/Cubits/Chat_cubit/cubit/chat_cubit.dart';
import 'package:chat3/Pages/Chatpage.dart';
import 'package:chat3/Pages/Regstier_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: 3,
        ),
        () => checkemail());
  }

  Future<Object?> getpref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    var prefEmail = preferences.get(
      "email",
    );
    return prefEmail;
  }

  checkemail() async {
    Object? email = await getpref();
    if (email != null) {          BlocProvider.of<ChatCubit>(context).getMessage();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ChatPage(
          email: email as String,
        );
      }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/mainicon.png",
        ),
      ),
    );
  }
}
