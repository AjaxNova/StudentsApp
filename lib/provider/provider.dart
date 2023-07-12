import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/core/constant/colors.dart';

import '../core/constant/functions.dart';
import '../database/model/model.dart';

class StudentListProvider with ChangeNotifier {
  List<StudentData> theStudentLIst = [];

  addNewStudents(StudentData data, BuildContext context) async {
    theStudentLIst.add(data);
    final studentDB = await Hive.openBox<StudentData>("student_db");
    await studentDB.add(data);
    notifyListeners();
  }

  getAllStudentList() async {
    final studentDb = await Hive.openBox<StudentData>("student_db");
    theStudentLIst.clear();
    theStudentLIst.addAll(studentDb.values);
  }

  deleteStudent(int index) async {
    final studentDb = await Hive.openBox<StudentData>("student_db");
    studentDb.deleteAt(index);
    theStudentLIst.removeAt(index);
    notifyListeners();
  }

  updateStudentData(
      {required StudentData data,
      required int index,
      required BuildContext context}) async {
    final studentDB = await Hive.openBox<StudentData>("student_db");

    if (studentDB.values.elementAt(index).imagePath == data.imagePath &&
        studentDB.values.elementAt(index).name == data.name &&
        studentDB.values.elementAt(index).age == data.age &&
        studentDB.values.elementAt(index).phone == data.phone &&
        studentDB.values.elementAt(index).email == data.email) {
      showStudentAddedSnackbar(context, "no changes are made", kOrangeColor);
      return false;
    } else {
      studentDB.put(index, data);
      theStudentLIst[index] = data;
      notifyListeners();

      return true;
    }
  }
}
