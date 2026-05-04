import 'package:bookly_app/core/function/launch_url.dart';
import 'package:bookly_app/core/widget/custom_button.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class BookAction extends StatelessWidget {
  const BookAction({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: CustomButton(
            backgroundColor: Colors.white,
            text: 'Free',
            textColor: Colors.black,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
        ),
        Expanded(
          child: CustomButton(
            onPressed: () {
              launchCustomUrl(context, book.volumeInfo!.previewLink!);
            },
            backgroundColor: Colors.orange,
            text: getText(book),
            textColor: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

String getText(BookModel book) {
  if (book.volumeInfo!.previewLink == null) {
    return 'Not Avaliable';
  } else {
    return 'Preview';
  }
}
