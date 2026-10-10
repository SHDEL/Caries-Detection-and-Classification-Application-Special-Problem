import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// ดึงข้อมูลโปรไฟล์และ Sync User ลง PostgreSQL ใน Backend
  static Future<Response> syncUserProfile() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) throw Exception('No Firebase ID Token found');

    return await _dio.get(
      '/me',
      options: Options(headers: {'Authorization': 'Bearer $idToken'}),
    );
  }
}
