import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_app/core/constant/colors.dart';
import 'package:student_app/core/constant/functions.dart';
import 'package:student_app/presentation/add_new_student/add_new_student.dart';
import 'package:student_app/presentation/widgets/search.dart';
import 'package:student_app/provider/photo_provider.dart';
import 'package:student_app/provider/provider.dart';

class StudentListView extends StatelessWidget {
  const StudentListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoNoti = Provider.of<PhotoProviderNotifier>(context);

    return Consumer<StudentListProvider>(
      builder: (context, studentProvider, child) => Scaffold(
          backgroundColor: backgroundGradient.colors.last,
          appBar: AppBar(
            titleTextStyle: const TextStyle(color: Colors.white),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: SearchWidget());
                  },
                  icon: const Icon(Icons.search))
            ],
            title: const Text('Student List'),
            backgroundColor: backgroundGradient.colors[1],
          ),
          body: studentProvider.theStudentLIst.isNotEmpty
              ? ListView.builder(
                  itemCount: studentProvider.theStudentLIst.length,
                  itemBuilder: (context, index) {
                    final student = studentProvider.theStudentLIst[index];
                    return Dismissible(
                      key: Key(student.name),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) async {
                        studentProvider.deleteStudent(index);
                        showStudentAddedSnackbar(
                            context, "Student removed", kRedColor);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          semanticContainer: true,
                          color: const Color(0xFF103C54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () {
                              photoNoti
                                  .initPhotoNotifier(File(student.imagePath));

                              goto(
                                context: context,
                                pageTogo: AddNewStudent(
                                  check: 2,
                                  index: index,
                                  data: student,
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Hero(
                                  tag: 'image$index',
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                    child: Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF092E3E),
                                            Color(0xFF0C384F),
                                          ],
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                              File(student.imagePath)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 12.0, 16.0, 16.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          const Color(0xFF07202D)
                                              .withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16.0),
                                        bottomRight: Radius.circular(16.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Text(
                                            student.name.toString(),
                                            style: const TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          'Age: ${student.age.toString()}',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Email: ${student.email}',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Phone: ${student.phone}',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Container(
                    width: double.maxFinite,
                    color: backgroundGradient.colors[1],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.no_accounts,
                          size: 120.0,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'No students found.',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddNewStudent(check: 1, index: 0),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            backgroundColor: backgroundGradient.colors[0],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Add New Student',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          floatingActionButton: studentProvider.theStudentLIst.isNotEmpty
              ? FloatingActionButton(
                  backgroundColor: backgroundGradient.colors[2],
                  onPressed: () {
                    goto(
                        context: context,
                        pageTogo: const AddNewStudent(check: 1, index: 0));
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox()),
    );
  }
}
