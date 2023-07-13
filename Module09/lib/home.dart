import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final jsonString =
    await rootBundle.loadString('assets/ecom.JSON');
    final jsonData = json.decode(jsonString);
    final recipeList = jsonData['recipes'] as List<dynamic>;
    recipes = recipeList.map((json) => Recipe.fromJson(json)).toList();
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: recipes != null
          ? ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            leading: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.fastfood),
            ),
            title: Text(recipe.title),
            subtitle: Text(recipe.description),
            onTap: () {},
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}