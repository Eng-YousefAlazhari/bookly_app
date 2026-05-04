import 'package:bookly_app/core/utils/api_server.dart';
import 'package:bookly_app/features/home/data/repo/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServicesLocator() {
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      ApiServer(
        Dio(),
      ),
    ),
  );
}
