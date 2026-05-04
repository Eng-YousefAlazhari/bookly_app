import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailur extends Failure {
  ServerFailur(super.errorMessage);

  factory ServerFailur.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailur('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailur('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailur('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailur('Bad Certificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailur.frombadResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailur('Request to ApiServer was cancel');
      case DioExceptionType.connectionError:
        return ServerFailur('No Internet connection');
      case DioExceptionType.unknown:
        return ServerFailur('Opps there was an error, Please try again');
    }
  }

  factory ServerFailur.frombadResponse(int statecode, dynamic badResponse) {
    if (statecode == 400 || statecode == 401 || statecode == 403) {
      return ServerFailur(badResponse['error']['message']);
    } else if (statecode == 404) {
      return ServerFailur('Your request not found, Please try later!');
    } else if (statecode == 500) {
      return ServerFailur('Internal Server error, Please try later!');
    } else {
      return ServerFailur('Opps there was an error, Please try again');
    }
  }
}
