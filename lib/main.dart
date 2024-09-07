import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/welcome.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      home:  FutureBuilder(
        future: _checkFirstRun(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            bool isFirstRun = snapshot.data as bool;
            return isFirstRun ? const Welcome() : const HomeScreen();
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}

Future<bool> _checkFirstRun() async{
  final prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('isFirstRun')?? true;
  if(isFirstRun){
    await prefs.setBool('isFirstRun', false);
  }
  return isFirstRun;
}