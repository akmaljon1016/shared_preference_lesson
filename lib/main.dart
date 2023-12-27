import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtController = TextEditingController();

  String text = "";

  void saqlash(String text) async {
    pref.setString("txt", text);
  }

  void oqibOlish() {
    setState(() {
      text = pref.getString("txt")??"";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreference"),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtController,
            decoration: InputDecoration(hintText: "text kiriting..."),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              saqlash(txtController.text);
            },
            child: Text("Saqlash"),
            color: Colors.green,
          ),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
              onPressed: () {
                oqibOlish();
              },
              child: Text("O'qib olish"),
              color: Colors.green),
          Text(text)
        ],
      ),
    );
  }
}
