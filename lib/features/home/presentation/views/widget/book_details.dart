import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRatting extends StatelessWidget {
  const BookRatting(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      required this.count});

  final int count;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 35),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            FontAwesomeIcons.solidStar,
            size: 20,
            color: Color(0xffFFDD4f),
          ),
          const SizedBox(
            width: 7,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '($count)',
            style: Styles.textStyle16.copyWith(
              color: const Color.fromARGB(119, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
