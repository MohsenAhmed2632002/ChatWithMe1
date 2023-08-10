import 'package:chat3/Cubits/Chat_cubit/cubit/chat_cubit.dart';
import 'package:chat3/Cubits/Login_cubit/login_cubit.dart';
import 'package:chat3/Cubits/Regster_cubit/regsiter_cubit.dart';
import 'package:chat3/Provider/Light_provider.dart';
import 'package:chat3/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Pages/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => LoginCubit(),
    ),
    BlocProvider(
      create: (context) => RegsiterCubit(),

    ),BlocProvider(
      create: (context) => ChatCubit(),
      
    ),
  ], child: MainPro()));
}

class MainPro extends StatelessWidget {
  const MainPro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeModel.currenttheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
