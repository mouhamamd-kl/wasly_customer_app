import 'package:get/get.dart';
import 'package:wasly/controllers/services/storage/secure_storage_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs; // Observable to track login status
  final SecureStorageService _secureStorage = SecureStorageService();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final token = await _secureStorage.readToken();
    isLoggedIn.value = token != null;
  }

  Future<void> login(String token) async {
    await _secureStorage.saveToken(token);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await _secureStorage.clearToken();
    isLoggedIn.value = false;
  }
}
