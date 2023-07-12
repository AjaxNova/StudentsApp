import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app/core/constant/functions.dart';
import 'package:student_app/presentation/add_new_student/widgets/form.dart';
import 'package:student_app/provider/photo_provider.dart';
import 'package:student_app/provider/provider.dart';

import '../../core/constant/colors.dart';
import '../../database/model/model.dart';

class AddNewStudent extends StatefulWidget {
  const AddNewStudent({
    super.key,
    required this.check,
    this.data,
    required this.index,
    this.status,
  });
  final int index;
  final StudentData? data;

  final int check;

  final bool? status;

  @override
  State<AddNewStudent> createState() => _AddNewStudentState();
}

class _AddNewStudentState extends State<AddNewStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    if (widget.check != 1) {
      nameController.text = widget.data!.name;
      ageController.text = widget.data!.age;
      mobileController.text = widget.data!.phone;
      emailController.text = widget.data!.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  clearFieldAll() {
    nameController.text = "";
    ageController.text = "";
    mobileController.text = "";
    emailController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final studentProvider = Provider.of<StudentListProvider>(context);
    final photoNotiProvider = Provider.of<PhotoProviderNotifier>(context);

    popIt() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: backgroundGradient.colors[1],
      appBar: AppBar(
          backgroundColor: backgroundGradient.colors[1],
          leading: IconButton(
            onPressed: () {
              photoNotiProvider.clearPhotoNotifier();
              clearFieldAll();

              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
          title: widget.check == 1
              ? const Text(
                  'Add New Student',
                  style: TextStyle(color: Colors.white),
                )
              : Text("${widget.data!.name}'s Details")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            widget.check == 1
                ? ImageWidget(
                    size: size,
                    check: widget.check,
                  )
                : ImageWidget(
                    size: size,
                    check: widget.check,
                    photoPath: widget.data!.imagePath),
            SizedBox(
              height: size.height / 17,
            ),
            FormWidget(
              studentData: widget.data,
              check: widget.check,
              labelText: "name",
              controller: nameController,
              controllerOption: 1,
            ),
            const SizedBox(height: 20),
            FormWidget(
              studentData: widget.data,
              check: widget.check,
              labelText: "age",
              textInputType: TextInputType.number,
              controller: ageController,
              controllerOption: 2,
            ),
            const SizedBox(height: 20),
            FormWidget(
              studentData: widget.data,
              check: widget.check,
              labelText: "PhoneNumber",
              textInputType: TextInputType.number,
              controller: mobileController,
              controllerOption: 3,
            ),
            const SizedBox(height: 20),
            FormWidget(
              studentData: widget.data,
              check: widget.check,
              labelText: "email",
              controller: emailController,
              controllerOption: 4,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  width: 170,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: Colors.white)),
                        shape: MaterialStateProperty.all<OutlinedBorder?>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            backgroundGradient.colors.first)),
                    onPressed: () async {
                      if (nameController.value.text.isEmpty ||
                          ageController.value.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          emailController.value.text.isEmpty) {
                        showStudentAddedSnackbar(
                            context, "Fill the Form Correctly ", Colors.red);
                      } else if (int.parse(ageController.value.text) > 23) {
                        showStudentAddedSnackbar(
                            context, "Age is not appropiate ", Colors.red);
                      } else if (mobileController.value.text.length != 10) {
                        showStudentAddedSnackbar(
                            context, "Phone number is invalid  ", Colors.red);
                      } else if (!emailController.value.text
                          .contains("@gmail.com")) {
                        showStudentAddedSnackbar(
                            context, " Email is not Valid", Colors.red);
                      } else if (photoNotiProvider.photoNotifier?.path ==
                          null) {
                        showStudentAddedSnackbar(
                            context, "image is not added", Colors.red);
                      } else {
                        if (widget.check != 1) {
                          final data = StudentData(
                              age: ageController.value.text,
                              email: emailController.value.text,
                              name: nameController.value.text,
                              phone: mobileController.value.text,
                              imagePath: photoNotiProvider.photoNotifier!.path);
                          final bool? value =
                              await studentProvider.updateStudentData(
                            data: data,
                            index: widget.index,
                            context: context,
                          );
                          if (value == true) {
                            photoNotiProvider.clearPhotoNotifier();
                            clearFieldAll();
                            showStudentAddedSnackbar(
                                context, "Student is updated", kOrangeColor);
                            popIt();
                          }
                        } else {
                          final datas = StudentData(
                              age: ageController.value.text,
                              email: emailController.value.text,
                              name: nameController.value.text,
                              phone: mobileController.value.text,
                              imagePath: photoNotiProvider.photoNotifier!.path);
                          studentProvider.addNewStudents(datas, context);
                          clearFieldAll();
                          photoNotiProvider.clearPhotoNotifier();
                          showStudentAddedSnackbar(
                              context, "new Student is Added", kGreenColor);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text(
                      widget.check == 1 ? "Submit" : "Edit",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key, required this.size, required this.check, this.photoPath});

  final Size size;
  final int check;
  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    final photoNotiProvider = Provider.of<PhotoProviderNotifier>(context);

    return Stack(
      children: [
        photoNotiProvider.photoNotifier?.path == null
            ? Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                    backgroundColor: backgroundGradient.colors[2],
                    radius: 80,
                    child: const Icon(Icons.person_2_outlined)))
            : Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      FileImage(File(photoNotiProvider.photoNotifier!.path)),
                )),
        Positioned(
          left: size.width / 3.1,
          bottom: -2,
          child: SizedBox(
            height: 35,
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        backgroundGradient.colors.first)),
                child: check == 1
                    ? const Text(
                        "add photo ",
                        style: TextStyle(fontSize: 17),
                      )
                    : const Text("Edit Photo"),
                onPressed: () async {
                  final photo = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (photo?.path == null) {
                    return;
                  } else {
                    final File photoFile = File(photo!.path);
                    photoNotiProvider.initPhotoNotifier(photoFile);
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
