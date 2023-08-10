import 'package:chat3/models.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginButton extends StatelessWidget {
  LoginButton({
    required this.onTap,
    super.key,
  });
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Center(
          child: Icon(
            Icons.login_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginFormField extends StatelessWidget {
  LoginFormField({
    required this.onChange,
    required this.lable,
    required this.icon,
  });
  final String lable;
  final IconData icon;
  Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "put some date";
        }
        return null;
      },
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefixIconColor: Colors.black,
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        label: Text(
          lable,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class UiMass extends StatelessWidget {
  UiMass({
    super.key,
    // required int index,
  });
  // int? index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blueAccent[400],
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Text(" First M"),
        // $index
      ),
    );
  }
}

class ComponantChat extends StatelessWidget {
  const ComponantChat({
    super.key,
    required this.messagelist,
    required this.index,
  });

  final List<Message> messagelist;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Text("${messagelist[index].message}"),
      ),
    );
  }
}

class ComponantChat2 extends StatelessWidget {
  const ComponantChat2({
    super.key,
    required this.messagelist,
    required this.index,
  });

  final List<Message> messagelist;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Text("${messagelist[index].message}"),
      ),
    );
  }
}
