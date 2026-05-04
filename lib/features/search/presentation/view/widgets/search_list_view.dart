import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/presentation/views/widget/custom_book_image_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kBookDetailsView);
                },
                child: const SizedBox(
                  height: 140,
                  child: CustomBookIamgeItem(
                    imageUrl:
                        'https://i0.wp.com/kareninglisauthor.com/wp-content/uploads/2018/05/tsl-50-thumbnail-300-dpi.jpg?resize=204%2C311&ssl=1',
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
                      child: const Text(
                        'Harry Potter and the Goblet of Fire',
                        style: Styles.textStyle22,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'J.K. Rowling',
                      style: Styles.textStyle14.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
