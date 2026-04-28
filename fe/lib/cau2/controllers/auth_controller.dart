import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fe/routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _auth.currentUser;
    _auth.authStateChanges().listen((user) {
      currentUser.value = user;
    });
  }

  String? get userEmail => currentUser.value?.email;

  bool get isLoggedIn => currentUser.value != null;

  Future<bool> register(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      errorMessage.value = 'Vui lòng nhập đầy đủ email và mật khẩu';
      return false;
    }
    if (password.length < 6) {
      errorMessage.value = 'Mật khẩu phải có ít nhất 6 ký tự';
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      isLoading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      errorMessage.value = _mapFirebaseError(e.code);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      errorMessage.value = 'Vui lòng nhập đầy đủ email và mật khẩu';
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      isLoading.value = false;
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      errorMessage.value = _mapFirebaseError(e.code);
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Không tìm thấy tài khoản với email này';
      case 'wrong-password':
        return 'Mật khẩu không đúng';
      case 'email-already-in-use':
        return 'Email này đã được sử dụng';
      case 'invalid-email':
        return 'Email không hợp lệ';
      case 'weak-password':
        return 'Mật khẩu quá yếu (cần ít nhất 6 ký tự)';
      case 'user-disabled':
        return 'Tài khoản đã bị vô hiệu hóa';
      case 'too-many-requests':
        return 'Quá nhiều lần thử, vui lòng thử lại sau';
      default:
        return 'Đã xảy ra lỗi, vui lòng thử lại';
    }
  }
}
