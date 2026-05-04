import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widget/book_details.dart';
import 'package:bookly_app/features/home/presentation/views/widget/custom_book_image_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsListViewItem extends StatelessWidget {
  const NewsListViewItem({super.key, required this.book});

  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: book);
          },
          child: SizedBox(
            height: 140,
            child: CustomBookIamgeItem(
              imageUrl: book.volumeInfo!.imageLinks!.thumbnail!,
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Text(
                  book.volumeInfo!.title!,
                  style: Styles.textStyle22,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                book.volumeInfo!.publishedDate!,
                style: Styles.textStyle14.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    'Free',
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  BookRatting(
                    count: book.volumeInfo!.pageCount ?? 0,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
