import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/utils/api_server.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repo/repo_home.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements ReopHome {
  final ApiServer _apiServer;

  HomeRepoImpl(this._apiServer);

  @override
  Future<Either<Failure, List<BookModel>>> fetchBestSellerBooks() async {
    final Map<String, dynamic> data;
    try {
      data = await _apiServer.get(
          endPoing:
              'volumes?q=subject:programming&Flitering=free-ebooks&Sorting=newest');
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailur.fromDioException(e),
        );
      }
      return left(
        ServerFailur(e.toString()),
      );
    }

    List<BookModel> books = [];
    for (var item in data['items']) {
      books.add(BookModel.fromJson(item));
    }

    return right(books);
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchNewsBooks() async {
    final Map<String, dynamic> data;
    try {
      data = await _apiServer.get(
          endPoing: 'volumes?q=subject:programming&Flitering=free-ebooks');
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailur.fromDioException(e),
        );
      }
      return left(
        ServerFailur(e.toString()),
      );
    }

    List<BookModel> books = [];
    for (var item in data['items']) {
      books.add(BookModel.fromJson(item));
    }

    return right(books);
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
      {required String category}) async {
    final Map<String, dynamic> data;
    try {
      data = await _apiServer.get(
          endPoing:
              'volumes?q=subject:programming&Sorting=relevance&Flitering=free-ebooks');
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailur.fromDioException(e),
        );
      }
      return left(
        ServerFailur(e.toString()),
      );
    }

    List<BookModel> books = [];
    for (var item in data['items']) {
      books.add(BookModel.fromJson(item));
    }

    return right(books);
  }
}
