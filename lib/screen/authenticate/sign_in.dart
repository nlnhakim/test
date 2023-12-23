import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey <FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget> [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                  decoration:textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                  setState(() => email = val);
                }
              ),
          SizedBox(height: 20.0),
          TextFormField(
              decoration:textInputDecoration.copyWith(hintText: 'password'),
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
            }
          ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: ButtonStyle (
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                if(result == null) {
                  setState(() {
                    error = 'Could not sign in with those credentials';
                    loading = false;
                });
                }
              }
                },
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
        ],
        ),
      ),
      ),
    );
  }
}

// SIGN IN ANONYMOUS
//child: Text('Sign in anon'),
//onPressed: () async{
//dynamic result = await _auth.signInAnon();
//if(result == null){
//print('error signing in');
//} else{
//print('signed in');
//print(result.uid);
//}
//},