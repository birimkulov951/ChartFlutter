import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:core/core.dart';

final inject = GetIt.instance;

Future<void> init(String baseUrl) async {
  // BLoC
  inject.registerFactory(() => ThemeBloc(prefHelper: inject()));
  inject.registerFactory(() => ChartBloc(repository: inject()));


  // Repository
  inject.registerLazySingleton<Repository>(() =>
      MainRepository(apiRepository: inject(), localRepository: inject()));
  inject.registerLazySingleton(() => LocalRepository(prefHelper: inject()));
  inject.registerLazySingleton(() => ApiRepository(apiService: inject()));

  // Local
  final preferences = await SharedPreferences.getInstance();
  inject.registerLazySingleton(() => preferences);
  inject.registerLazySingleton(() => SharedPrefHelper(preferences: inject()));

  // Network
  inject.registerLazySingleton(() => ApiService(dio: inject()));
  inject.registerLazySingleton(() => inject<DioClient>().dio);
  inject.registerLazySingleton(() => DioClient(apiBaseUrl: baseUrl));

}
