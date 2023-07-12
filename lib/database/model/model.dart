import 'package:hive_flutter/hive_flutter.dart';

part 'model.g.dart';

@HiveType(typeId: 1)
class StudentData {
  @HiveField(0)
  String name;
  @HiveField(1)
  String phone;
  @HiveField(2)
  String email;
  @HiveField(3)
  String age;
  @HiveField(4)
  String imagePath;
  StudentData(
      {required this.age,
      required this.email,
      required this.name,
      required this.phone,
      required this.imagePath});
}
