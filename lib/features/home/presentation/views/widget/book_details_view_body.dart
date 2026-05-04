import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widget/custom_error_widget.dart';
import 'package:bookly_app/core/widget/custom_loading_indicator.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_book_cubit/similar_book_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widget/book_action.dart';
import 'package:bookly_app/features/home/presentation/views/widget/book_details.dart';
import 'package:bookly_app/features/home/presentation/views/widget/custom_book_details_app_bar.dart';
import 'package:bookly_app/features/home/presentation/views/widget/custom_book_image_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.book});
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookDetailsSection(
                book: book,
              ),
              const Expanded(
                child: SizedBox(
                  height: 50,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  'You may also like',
                  style: Styles.textStyle16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 135,
                child: SimilarBooksListView(
                  book: book,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBookCubit, SimilarBookState>(
      builder: (context, state) {
        if (state is SimilarBookSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.books.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomBookIamgeItem(
                    imageUrl:
                        state.books[index].volumeInfo!.imageLinks!.thumbnail!,
                  ),
                );
              },
            ),
          );
        } else if (state is SimilarBookFailure) {
          return CustomErrorWidget(errorMessage: state.errMessage);
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: CustomBookDetailsAppBar(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .2),
            child: CustomBookIamgeItem(
              imageUrl: book.volumeInfo!.imageLinks!.thumbnail!,
            ),
          ),
          const SizedBox(
            height: 43,
          ),
          Text(
            book.volumeInfo!.title!,
            textAlign: TextAlign.center,
            style: Styles.textStyle30,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            book.volumeInfo!.publishedDate!,
            style: Styles.textStyle18.copyWith(
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(170, 255, 255, 255)),
          ),
          const SizedBox(
            height: 18,
          ),
          BookRatting(
            count: book.volumeInfo!.pageCount!,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const SizedBox(
            height: 37,
          ),
          BookAction(
            book: book,
          )
        ],
      ),
    );
  }
}
