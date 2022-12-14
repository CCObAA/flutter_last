import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_applicationlast/views/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/setting_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String stroka = "";
  String theme = "";
  late SharedPreferences sharedPreferences;

  @override
  Future<void> initShared() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('stroka') && sharedPreferences.containsKey('theme')) 
    {
      Navigator.pushNamed(context, Screen.routeName, arguments: {
        'stroka1': sharedPreferences.getString('stroka'),
        'theme1': sharedPreferences.getString('theme1')
      });
    }
  }

  @override
  void initState() {
    initShared().then((value) {
      stroka = sharedPreferences.getString('stroka') ?? "";
      theme = sharedPreferences.getString('theme1') ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                sharedPreferences.setString('stroka', value);
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Screen.routeName,
                    arguments: {
                      'stroka1': sharedPreferences.getString('stroka'),
                      'theme1': sharedPreferences.getString('theme1')
                    },
                  );
                },
                child: const Text("Передать аргументы")),
            const SizedBox(
              height: 100,
              width: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<SettingCubit>().toogleTheme();
                if(context.read<SettingCubit>().state.theme == ThemeData.light())
                  sharedPreferences.setString('theme1', "light");
                else
                  sharedPreferences.setString('theme1', "black");
              },
              tooltip: 'Сменить тему',
              child:
                  context.read<SettingCubit>().state.theme == ThemeData.light()
                      ? const Icon(Icons.light)
                      : const Icon(Icons.light),
            ),
          ],
        ));
  }
}