import 'package:get_it/get_it.dart';
import 'package:glotist_app/core/data/repositories/language_repository.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/services/supabase_service.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:glotist_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service locator instance.
final GetIt sl = GetIt.instance;

/// Initializes the dependency injection container.
Future<void> init() async {
  // Services
  await SupabaseConfig.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(LanguageRepository.new)
    ..registerFactory(() => ThemeCubit(sl()))
    ..registerFactory(() => LocalizationCubit(sl(), sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      ChatRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(sl()),
    );

  // Blocs
  // sl.registerFactory(() => OnboardingBloc(sl()));
}
