import 'dart:io';

class ApiConfig {
  // تحديد العنوان حسب البيئة
  // 10.0.2.2 = Android Emulator
  // 127.0.0.1 = iOS Simulator, Windows, Mac, أو جهاز حقيقي متصل بنفس الشبكة
  static String get baseUrl {
    // يمكنك تغيير هذا حسب احتياجك
    if (Platform.isAndroid) {
      // للـ Android Emulator
      return 'http://10.0.2.2:8000/api';
    } else {
      // للـ iOS Simulator أو الأجهزة الحقيقية
      return 'http://127.0.0.1:8000/api';
    }
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 20);
}
