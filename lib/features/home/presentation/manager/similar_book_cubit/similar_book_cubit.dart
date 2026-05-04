import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repo/home_repo_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'similar_book_state.dart';

class SimilarBookCubit extends Cubit<SimilarBookState> {
  SimilarBookCubit(this.homeRepoImpl) : super(SimilarBookInitial());

  final HomeRepoImpl homeRepoImpl;

  Future<void> fetchSimilarBook({required String category}) async {
    emit(SimilarBookLoading());
    final result = await homeRepoImpl.fetchSimilarBooks(category: category);

    result.fold((failure) {
      return emit(SimilarBookFailure(errMessage: failure.errorMessage));
    }, (books) {
      return emit(SimilarBookSuccess(books: books));
    });
  }
}
