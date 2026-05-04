import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repo/home_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_books_state.dart';

class NewsBooksCubit extends Cubit<NewsBooksState> {
  NewsBooksCubit(this.homeRepoImpl) : super(NewsBooksInitial());

  final HomeRepoImpl homeRepoImpl;

  Future<void> fetchNewsBooks() async {
    emit(NewsBooksLoading());
    final result = await homeRepoImpl.fetchNewsBooks();

    result.fold((failure) {
      return emit(NewsBooksFailure(errMessage: failure.errorMessage));
    }, (books) {
      return emit(NewsBooksSuccess(books: books));
    });
  }
}
