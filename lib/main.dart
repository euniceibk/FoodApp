import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/food/food_bloc.dart';
import 'package:food_app/pages/HomePage.dart';
import 'package:food_app/repository/food_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto', hintColor: Color(0xFFd0cece)),
      home: BlocProvider(
        create: (context) => FoodBloc(repository: FoodRepository()),
        child: HomePage(),
      ),
    );
  }
}
