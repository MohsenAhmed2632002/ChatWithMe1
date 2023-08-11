import 'package:chat3/Cubits/Chat_cubit/cubit/chat_cubit.dart';
import 'package:chat3/Provider/Light_provider.dart';
import 'package:chat3/Widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.email,
  });
  final String? email;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // CollectionReference messages =
  //     FirebaseFirestore.instance.collection("Messages");
  final controllerS = ScrollController();
  TextEditingController controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  
  GlobalKey<FormState> _formKey = GlobalKey();
  String? localMessaage;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    
    return Form(
      key: _formKey,
      
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 7,
          title: Text(
            "${widget.email}",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  themeModel.changeTheme();
                });
              },
              icon: Icon(
                themeModel.currenttheme == ThemeData.light()
                    ? Icons.dark_mode_sharp
                    : Icons.brightness_4_rounded,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                          

                  return ListView.builder(
                    controller: controllerS,
                    itemCount: BlocProvider.of<ChatCubit>(context).messagelist.length ,
                    itemBuilder: (context, index) {
                      return  BlocProvider.of<ChatCubit>(context).messagelist[index].id == widget.email!
                          ? ComponantChat(
                              messagelist:  BlocProvider.of<ChatCubit>(context).messagelist, index: index)
                          : ComponantChat2(
                              messagelist:  BlocProvider.of<ChatCubit>(context).messagelist, index: index);
                    },
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) {
                    localMessaage = value;
  BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: localMessaage!, email: "${widget.email}");

                    controller.clear();
                    controllerS.animateTo(controllerS.position.maxScrollExtent,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOutCirc);
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Message",
                    border: OutlineInputBorder(),
                  ),
                )),
          ],
        ),
      ),
    );
  }
  // else if (snapshot.connectionState ==
  //     ConnectionState.waiting) {
  //   return NoData();
  // } else {
  //   return Error(snapshot: snapshot);
  // }
}
