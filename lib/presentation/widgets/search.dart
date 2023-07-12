import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/constant/colors.dart';
import 'package:student_app/provider/photo_provider.dart';
import 'package:student_app/provider/provider.dart';

import '../../core/constant/functions.dart';
import '../../database/model/model.dart';
import '../add_new_student/add_new_student.dart';

class SearchWidget extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: backgroundGradient.colors[0],
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<StudentData> dummyList = [];
    final studentProvider = Provider.of<StudentListProvider>(context);
    final photoNoti = Provider.of<PhotoProviderNotifier>(context);

    return Scaffold(
        backgroundColor: backgroundGradient.colors[1],
        body: ListView.builder(
          itemCount: studentProvider.theStudentLIst.length,
          itemBuilder: (context, index) {
            final data = studentProvider.theStudentLIst[index];
            if (data.name.startsWith(query.trim())) {
              dummyList.add(data);
              return Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () {
                        photoNoti.initPhotoNotifier(File(data.imagePath));

                        goto(
                          context: context,
                          pageTogo: AddNewStudent(
                            check: 2,
                            index: index,
                            data: data,
                          ),
                        );
                      },
                      title: Text(
                        data.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.imagePath)),
                      ),
                    ),
                  )
                ],
              );
            } else {
              if (index == studentProvider.theStudentLIst.length - 1 &&
                  dummyList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Text(
                      "No data for $query",
                      style: const TextStyle(color: kWhiteColor),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            }
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<StudentData> dummyList = [];
    final photoNoti = Provider.of<PhotoProviderNotifier>(context);

    final studentProvider = Provider.of<StudentListProvider>(context);

    return Scaffold(
        backgroundColor: backgroundGradient.colors[1],
        body: ListView.builder(
          itemCount: studentProvider.theStudentLIst.length,
          itemBuilder: (context, index) {
            final data = studentProvider.theStudentLIst[index];
            if (data.name.startsWith(query)) {
              dummyList.add(data);
              return Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListTile(
                      onTap: () {
                        photoNoti.initPhotoNotifier(File(data.imagePath));

                        goto(
                          context: context,
                          pageTogo: AddNewStudent(
                            check: 2,
                            index: index,
                            data: data,
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(data.imagePath)),
                      ),
                      title: Text(
                        data.name,
                        style: const TextStyle(color: kWhiteColor),
                      ),
                    ),
                  )
                ],
              );
            } else {
              if (index == studentProvider.theStudentLIst.length - 1 &&
                  dummyList.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Text(
                        "no result for $query",
                        style: const TextStyle(color: kWhiteColor),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }
          },
        ));
  }
}
