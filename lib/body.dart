import 'package:counterapp/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int number = 0;
  bool trueorFlase = true;

  @override
  void initState() {
    super.initState();
    getdatas();
    gettheme();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: trueorFlase ? Colors.white : Colors.grey.shade900,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: IconButton(
                onPressed: () {
                  icontheme();
                },
                iconSize: 30,
                icon: trueorFlase
                    ? Icon(Icons.light_mode_outlined)
                    : Icon(Icons.dark_mode_sharp)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    removeData();
                    
                    
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 40,
                    color: Colors.black,
                  )),
            )
          ],
          shape: Border.all(width: 3, color: Colors.black),
          elevation: 20,
          shadowColor: Colors.black,
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Counter App",
              style: TextStyle(
                  wordSpacing: 10, fontSize: 30, color: Colors.yellow),
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 30), child: SizedBox()),
        ),
        floatingActionButton: ClipOval(
          child: Material(
            color: Colors.black12,
            elevation: 1,
            shadowColor: trueorFlase ? Colors.black : Colors.white,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    number++;
                  });
                  setdatas(number);
                },
                icon: Icon(
                  Icons.exposure_plus_1_rounded,
                  color: trueorFlase ? Colors.black : Colors.white,
                  size: 70,
                )),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "$number",
                style: TextStyle(
                    fontSize: 60,
                    color: trueorFlase ? Colors.black : Colors.white),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    number = 0;
                  });
                  clear();
                },
                child: Text(
                  "Clear",
                  style: TextStyle(
                      fontSize: 20,
                      color: trueorFlase ? Colors.red.shade300 : Colors.yellow),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> setdatas(int value) async {
    SharedPreferences setdata = await SharedPreferences.getInstance();
    setdata.setInt("value", value);
  }

  Future<void> getdatas() async {
    SharedPreferences getdata = await SharedPreferences.getInstance();
    int? newnumber = await getdata.getInt("value");
    if (newnumber != null) {
      setState(() {
        number = newnumber;
      });
    }
  }

  void clear() async {
    SharedPreferences clearing = await SharedPreferences.getInstance();
    clearing.remove("value");
  }

  void icontheme() async {
    setState(() {
      if (trueorFlase == true) {
        trueorFlase = false;
      } else {
        trueorFlase = true;
      }
    });
    final SharedPreferences settheme = await SharedPreferences.getInstance();
    await settheme.setBool("bool", trueorFlase);
  }

  void gettheme() async {
    final SharedPreferences gettheme = await SharedPreferences.getInstance();
    bool? newbool = await gettheme.getBool("bool");

    setState(() {
      trueorFlase= newbool!;
    });
  }

  
}
