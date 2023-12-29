import 'package:flutter/material.dart';
import 'package:shared_preference_lesson/home_page.dart';
import 'package:shared_preference_lesson/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final SharedPreferences preferences;

  const LoginPage({super.key, required this.preferences});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String username, String password) {
    String savedUsername = widget.preferences.getString("username") ?? "";
    String savedPassword = widget.preferences.getString("password") ?? "";
    try{
      if (savedUsername == username && savedPassword == password) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
        widget.preferences.setBool("login",true);
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("username yoki parol xato")));
      }
    }
    catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login oynasi"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: "username"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: obscure,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: "password",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: Icon(obscure == true
                          ? Icons.visibility_off
                          : Icons.visibility))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                login(usernameController.text, passwordController.text);
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              height: 50,
              minWidth: MediaQuery.of(context).size.width,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage(preferences: widget.preferences)));

              },
              child: Text("Registratsiya qilish"))
        ],
      ),
    );
  }
}
