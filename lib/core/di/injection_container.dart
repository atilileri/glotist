import 'package:get_it/get_it.dart';
import 'package:glotist_app/core/services/supabase_service.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:glotist_app/features/chat/domain/repositories/chat_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Services
  await SupabaseConfig.initialize();

  // Data Sources
  sl
    ..registerLazySingleton<ChatRemoteDataSource>(
      ChatRemoteDataSourceImpl.new,
    )
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(sl()),
    );

  // Blocs
  // sl.registerFactory(() => OnboardingBloc(sl()));
}
