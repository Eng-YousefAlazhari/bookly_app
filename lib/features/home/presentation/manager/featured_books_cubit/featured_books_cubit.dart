import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repo/home_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepoImpl) : super(FeaturedBooksInitial());

  final HomeRepoImpl homeRepoImpl;

  Future<void> fecthFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    final result = await homeRepoImpl.fetchBestSellerBooks();

    result.fold((failure) {
      return emit(FeaturedBookFailure(errMessage: failure.errorMessage));
    }, (books) {
      return emit(FeaturedBooksSuccess(books: books));
    });
  }
}
