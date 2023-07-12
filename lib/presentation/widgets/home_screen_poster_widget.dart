import 'package:flutter/material.dart';
import 'package:student_app/core/constant/colors.dart';

class HomeScreenPoster extends StatelessWidget {
  const HomeScreenPoster({
    super.key,
    required this.size,
    required this.text,
    required this.icondata,
  });

  final Size size;
  final String text;
  final Icon icondata;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundGradient.colors[2],
          borderRadius: BorderRadius.circular(12)),
      height: size.height / 3.8,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: size.height / 3.8,
                  width: size.width / 2.2,
                  child: icondata),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: backgroundGradient.colors[2], width: 3),
                    color: Colors.black),
                width: size.width / 2.2,
                height: size.height / 21,
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
