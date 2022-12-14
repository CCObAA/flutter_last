import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_applicationlast/views/home_page.dart';
import 'package:flutter_applicationlast/views/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/setting_cubit.dart';
import 'cubit/setting_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingCubit()),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            routes: {
              Screen.routeName: (context) => const Screen(),
            },
            theme: state.theme,
            home: const MyHomePage(title: 'Практическая'),
          );
        },
      ),
    );
  }
}
