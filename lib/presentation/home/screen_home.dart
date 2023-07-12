import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/constant/colors.dart';
import 'package:student_app/core/constant/functions.dart';
import 'package:student_app/presentation/add_new_student/add_new_student.dart';
import 'package:student_app/presentation/student_list_view/studet_list_view.dart';
import 'package:student_app/provider/provider.dart';

import '../../core/constant/variables.dart';
import '../widgets/home_screen_poster_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentListProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundGradient.colors[0],
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(blackBoardurl)),
                        border: Border.all(color: kWhiteColor, width: .7)),
                    margin: EdgeInsets.only(bottom: size.height / 17),
                    height: size.height / 2.1,
                    width: double.infinity,
                    child: studentProvider.theStudentLIst.isEmpty
                        ? const Center(
                            child: Text(
                              "No recent activity ",
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 25),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final data =
                                  studentProvider.theStudentLIst[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 270,
                                        child: Text(
                                          "${data.name} is added to the list",
                                          overflow: TextOverflow.fade,
                                          style: const TextStyle(
                                              color: kGreyColor, fontSize: 20),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '9:00',
                                        style: TextStyle(
                                            color: kGreyColor, fontSize: 12),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: studentProvider.theStudentLIst.length,
                          )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            goto(
                                context: context,
                                pageTogo: const StudentListView());
                          },
                          child: HomeScreenPoster(
                            text: "Students List",
                            size: size,
                            icondata: const Icon(
                              Icons.book_outlined,
                              size: 65,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            goto(
                                context: context,
                                pageTogo: const AddNewStudent(
                                  index: 0,
                                  check: 1,
                                ));
                          },
                          child: HomeScreenPoster(
                            icondata: const Icon(
                              Icons.person_add,
                              size: 65,
                              color: kWhiteColor,
                            ),
                            text: "Add new",
                            size: size,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
