import 'package:flutter/material.dart';
import 'package:json_place_holder_albums/core/project_colors.dart';
import 'package:json_place_holder_albums/widget/albums_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: ProjectColors.blueColor,
            titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: ProjectColors.whiteColor,
                )),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AlbumsListView(),
    );
  }
}
