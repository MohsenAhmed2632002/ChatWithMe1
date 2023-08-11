import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../models.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection("Messages");

  List<Message> messagelist = [];
  void sendMessage({required String message, required String email}) {
    messages.add(
      {"message": message, "createdAt": "${DateTime.now()}", "id": "${email}"},
    );
  }

  void getMessage() {
    messages.orderBy("createdAt", ).snapshots().listen((event) {
      

      messagelist.clear();

      for (var doc in event.docs) {
       
        messagelist.add(Message.fromJson(doc));
      }
     
      emit(ChatSuccess(messages: messagelist));
    });
  }
}
