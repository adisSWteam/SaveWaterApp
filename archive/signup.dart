import 'package:flutter/material.dart';
import '../archive/auth_service.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String name = "";
  String email = "";
  String password = "";
  String passwordConfirm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 65, 0, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      SizedBox(width: 10),
                      Image(
                        image: AssetImage('assets/adislogo.png'),
                        height: 100,
                      ),
                      SizedBox(width: 140),
                      Image(
                        image: AssetImage('assets/waterdrop.png'),
                        height: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        hintText: 'Full Name',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      // validator: (val) =>
                      //     val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        hintText: 'Email Address',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter an email' : "",
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : "",
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(width: 1),
                        //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // ),
                        hintText: 'Confirm Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Password is not the same' : "",
                      onChanged: (val) {
                        setState(() => passwordConfirm = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ignore: deprecated_member_use
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signUpWithEmailAndPassword(
                            email, password);
                        setState(() {
                          if (result.runtimeType == String) {
                            var snackbar = SnackBar(content: Text(result));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      foregroundColor: Colors.indigo[700],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Or Use a Social Platform to Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MaterialButton(
                    onPressed: () {},
                    shape: const CircleBorder(),
                    child: const Image(
                      image: AssetImage('assets/googleLogo.png'),
                      height: 15,
                    ),
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 75),
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
