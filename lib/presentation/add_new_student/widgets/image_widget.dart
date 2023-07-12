import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 80,
          ),
        ),
        Positioned(
          left: size.width / 3.1,
          bottom: -2,
          child: SizedBox(
            height: 35,
            width: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ElevatedButton(
                style: const ButtonStyle(),
                child: const Text(
                  "add photo ",
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
