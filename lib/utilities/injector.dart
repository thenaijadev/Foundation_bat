import 'package:batnf/features/authentication/presentation/repository/change_password.dart';
import 'package:batnf/features/authentication/presentation/repository/change_password_impl.dart';
import 'package:batnf/features/home/data/projects/respository/events/event_impl.dart';
import 'package:batnf/features/home/data/projects/respository/events/events.dart';
import 'package:batnf/features/home/data/projects/respository/media_centre/news.dart';
import 'package:batnf/features/home/data/projects/respository/media_centre/news_impl.dart';
import 'package:batnf/features/home/data/projects/respository/projects/project_impl.dart';
import 'package:batnf/features/home/data/projects/respository/projects/projects.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Initializes all dependencies.
/// We register as lazy singletons to boost performance
/// meaning, Get It would instantiate objects on demand
Future<void> init() async {
  //! Repositories
  //eg: sl.registerLazySingleton<IPokemonRemoteDataSource>(() => PokemonRemoteDataSourceImpl(client: sl())
  // );
  sl.registerLazySingleton<ProjectRepository>(() => GetProjectImpl());
  sl.registerLazySingleton<EventRepository>(() => GetEventImpl());
  sl.registerLazySingleton<NewsRepository>(() => GetNewsImpl());
  sl.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordImpl());

  //! Data sources
  //eg: sl.registerLazySingleton<ICacheDataSource>(() => CacheDataSourceImpl(sl()));

  //! Core
  //eg: sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //eg: sl.registerLazySingleton(() => http.Client());
}
