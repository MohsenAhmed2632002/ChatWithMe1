import 'package:chat3/Provider/Light_provider.dart';
import 'package:chat3/Widgets/Widgets.dart';
import 'package:chat3/models.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
  

  final controllerS = ScrollController();
  TextEditingController controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference messages =
      FirebaseFirestore.instance.collection("Messages");
  GlobalKey<FormState> _formKey = GlobalKey();
  String? localMessaage;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    return Form(
      key: _formKey,
      child: StreamBuilder<QuerySnapshot>(
          stream: messages
              .orderBy(
                "createdAt",
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Message> messagelist = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                messagelist.add(
                  Message.fromJson(
                    snapshot.data!.docs[i],
                  ),
                );
              }
              return Scaffold(
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
                      child: ListView.builder(
                        controller: controllerS,
                        itemCount: messagelist.length,
                        itemBuilder: (context, index) {
                          return messagelist[index].id == widget.email!
                              ? ComponantChat(
                                  messagelist: messagelist, index: index)
                              : ComponantChat2(
                                  messagelist: messagelist, index: index);
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller,
                          onFieldSubmitted: (value) {
                            localMessaage = value;

                            messages.add(
                              {
                                "message": value,
                                "createdAt": "${DateTime.now()}",
                                "id": "${widget.email}"
                              },
                            );
                            controller.clear();
                            controllerS.animateTo(
                                controllerS.position.maxScrollExtent,
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
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return NoData();
            } else {
              return Error(snapshot:snapshot);
            }
          }),
    );
  }
}

class Error extends StatelessWidget {
   Error({
    super.key,required var snapshot,
  });
var snapshot;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Scaffold(
        body: Center(
          child: Text(
            "the e :${snapshot.error}",
          ),
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text(
            "wait.....",
          ),
        ),
      ),
    );
  }
}
