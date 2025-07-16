import 'package:get_it/get_it.dart';
import 'controllers/chat_controller.dart';
import 'controllers/theme_controller.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize services
  final storageService = StorageService();
  await storageService.init();

  // Register services
  locator.registerSingleton<ApiService>(ApiService());
  locator.registerSingleton<StorageService>(storageService);

  // Register controllers
  locator.registerLazySingleton<ChatController>(
    () => ChatController(
      apiService: locator<ApiService>(),
      storageService: locator<StorageService>(),
    ),
  );

  locator.registerLazySingleton<ThemeController>(() => ThemeController());
}
