import 'package:counterapp/body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void removeData() async {
  final SharedPreferences delete = await SharedPreferences.getInstance();
  delete.clear();
}

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? name;
  String? pass;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  Future<void> checkdata() async {
    if (name != null && pass != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return MyApp();
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    getDatas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.lightBlue,
              Colors.grey.shade300,
              Colors.purple.shade100,
              Colors.purple
            ])),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 200,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return "Enter Valid Name";
                      }
                      return null;
                    },
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: "Enter UserName",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < 8 || value.isEmpty) {
                        return "Enter Valid Password Must Contain 8";
                      }
                      return null;
                    },
                    controller: _pass,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(20),
                        minimumSize: WidgetStateProperty.all(Size(150, 50)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.red.shade400),
                      ),
                      onPressed: () {
                        _formKey.currentState!.validate();
                        screenPass(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void screenPass(BuildContext context) {
    final name = _name.text;
    final pass = _pass.text;
    if (name.isNotEmpty &&
        pass.isNotEmpty &&
        name.length > 4 &&
        pass.length > 7) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return MyApp();
      }));
      setDatas(name, pass);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Enter Valid Details"),margin: EdgeInsets.all(10),behavior: SnackBarBehavior.floating,backgroundColor: Colors.red,
        ), 
      );
    }
  }

  Future<void> setDatas(String name, String pass) async {
    final SharedPreferences setName = await SharedPreferences.getInstance();
    setName.setString("name", name);

    final SharedPreferences setPass = await SharedPreferences.getInstance();
    setPass.setString("pass", pass);
  }

  Future<void> getDatas() async {
    final SharedPreferences getName = await SharedPreferences.getInstance();
    name = await getName.getString("name");
    final SharedPreferences getpass = await SharedPreferences.getInstance();
    pass = await getpass.getString("pass");
    checkdata();
    
      print(name!);
    
  }
}
