// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/Views/show_dialogs.dart';
import 'package:untitled1/enum/menu_action.dart';
import 'package:untitled1/services/auth/auth_services.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/notes.png'),
        fit: BoxFit.fill,
      ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: const Text('All Notes'),
          backgroundColor: Colors.purple,
          elevation: 20,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              side: BorderSide(
                  width: 4.0,
                  color: Colors.lightBlue,
                  style: BorderStyle.solid)),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                      value: MenuAction.logout, child: Text('Log Out'))
                ];
              },
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutDialog(context);
                    if (shouldLogout) {
                      AuthServices.firebase().logOut();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/login/", (route) => false);
                    }
                }
              },
            ),
          ],
        ),
        drawer: const Drawer(),
      ),
    );
  }
}
