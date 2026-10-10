import 'package:caries_scan_app/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ดึงข้อมูล Current User ปัจจุบัน
  static User? get currentUser => _auth.currentUser;

  /// Stream ตรวจสอบสถานะการล็อกอินแบบ Realtime
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// ดึง Firebase ID Token ล่าสุด
  static Future<String?> getIdToken() async {
    return await _auth.currentUser?.getIdToken();
  }

  /// สมัครสมาชิกด้วย Email & Password + Sync ข้อมูลไปยัง Go Backend
  static Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    String? username,
  }) async {
    // 1. สร้าง User บน Firebase
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. อัปเดต Display Name (ถ้ามี)
    if (username != null && username.isNotEmpty) {
      await credential.user?.updateDisplayName(username);
    }

    // 3. ส่ง Token ไปยัง Go Backend เพื่อสร้าง/ซิงค์ User ใน PostgreSQL
    await ApiService.syncUserProfile();

    return credential;
  }

  /// เข้าสู่ระบบด้วย Email & Password + Sync ข้อมูลไปยัง Go Backend
  static Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Sync ข้อมูลผู้ใช้ทุกครั้งที่ล็อกอิน (เผื่อข้อมูลอัปเดต)
    await ApiService.syncUserProfile();

    return credential;
  }

  /// ออกจากระบบ
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {}
}
