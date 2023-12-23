import 'package:brew_crew/screen/authenticate/authenticate.dart';
import 'package:brew_crew/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/MyUser.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);


    // return either home or authenticate
   if (user == null) {
     return Authenticate();
   } else {
     return Home();
   }
  }
}
