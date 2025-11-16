# **README.md**

```markdown
# 🔐 Firebase Authentication Flutter App

مشروع تعليمي شامل يوضح كيفية بناء نظام مصادقة متكامل باستخدام **Flutter** و **Firebase Authentication**. يحتوي على جميع الميزات الأساسية لنظام تسجيل الدخول الاحترافي.

A comprehensive educational project demonstrating how to build a complete authentication system using **Flutter** and **Firebase Authentication**. Includes all essential features of a professional login system.

## 🌟 المميزات / Features

### ✅ المصادقة الأساسية / Basic Authentication
- **تسجيل الدخول** / Login with email & password
- **إنشاء حساب** / User registration
- **استعادة كلمة المرور** / Password recovery
- **تسجيل الخروج** / Logout functionality

### 🔗 المصادقة الاجتماعية / Social Authentication
- **تسجيل الدخول بحساب Google** / Google Sign-In integration

### 📧 إدارة الحساب / Account Management
- **التحقق من البريد الإلكتروني** / Email verification
- **إعادة إرسال رابط التحقق** / Resend verification link
- **إدارة حالة المستخدم** / User state management

### 🎨 واجهة المستخدم / User Interface
- **واجهة عربية كاملة** / Full Arabic UI support
- **تصميم متجاوب** / Responsive design
- **تجربة مستخدم محسنة** / Enhanced user experience
- **معالجة الأخطاء** / Comprehensive error handling

## 🛠 التقنيات المستخدمة / Technologies Used

- **Flutter** - إطار العمل / Framework
- **Firebase Authentication** - إدارة المصادقة / Authentication Management
- **GetX** - إدارة الحالة والتنقل / State Management & Navigation
- **Google Sign-In** - المصادقة الاجتماعية / Social Authentication
- **Material Design** - تصميم الواجهات / UI Design

## 📱 لقطات الشاشة / Screenshots

| تسجيل الدخول / Login | إنشاء حساب / Sign Up | استعادة كلمة المرور / Forgot Password |
|---------------------|---------------------|-------------------------------------|
| ![Login](screenshots/login.png) | ![SignUp](screenshots/signup.png) | ![Forgot](screenshots/forgot.png) |

| الصفحة الرئيسية / Homepage | التحقق من البريد / Verify Email |
|--------------------------|-------------------------------|
| ![Home](screenshots/home.png) | ![Verify](screenshots/verify.png) |

## ⚙️ التثبيت والإعداد / Installation & Setup

### المتطلبات الأساسية / Prerequisites
- Flutter SDK
- Firebase Project
- Android Studio / VS Code

### خطوات التثبيت / Installation Steps

1. **استنساخ المستودع** / Clone the repository
```bash
git clone https://github.com/your-username/authenticaion_app.git
cd authenticaion_app
```

2. **تثبيت dependencies** / Install dependencies
```bash
flutter pub get
```

3. **إعداد Firebase** / Firebase Setup
   - أنشئ مشروع جديد في [Firebase Console](https://console.firebase.google.com)
   - أضف تطبيق Android/iOS
   - حمل ملف `google-services.json` للمشروع
   - فعّل Authentication وأضف مقدمي الخدمة:
     - Email/Password
     - Google

4. **تشغيل التطبيق** / Run the app
```bash
flutter run
```

## 🏗 هيكل المشروع / Project Structure

```
lib/
├── main.dart                 # نقطة الدخول الرئيسية
├── wrapper.dart             # مدير حالة المصادقة
├── login.dart               # صفحة تسجيل الدخول
├── sign_up.dart             # صفحة إنشاء حساب
├── forgotten_password.dart  # صفحة استعادة كلمة المرور
├── virefyemail.dart         # صفحة التحقق من البريد
├── homepage.dart            # الصفحة الرئيسية
└── models/                  # النماذج
```

## 🔧 التكوين / Configuration

### إعداد Firebase Authentication

1. في Firebase Console، اذهب إلى **Authentication**
2. في علامة التبويب **Sign-in method**، فعّل:
   - **Email/Password**
   - **Google**

### إعداد Google Sign-In

1. أضف بصمة SHA-1 لمشروعك في Firebase Console
2. تأكد من تكوين `google-services.json` بشكل صحيح

## 🚀 الاستخدام / Usage

### دورة حياة المستخدم / User Lifecycle

1. **مستخدم جديد** → إنشاء حساب → التحقق من البريد → الصفحة الرئيسية
2. **مستخدم موجود** → تسجيل الدخول → الصفحة الرئيسية
3. **نسيت كلمة المرور** → استعادة عبر البريد → تحديث كلمة المرور

### الحالات المحتملة / Possible States

- **غير مسجل الدخول** → شاشة تسجيل الدخول
- **مسجل الدخول - بريد غير مفعل** → شاشة التحقق
- **مسجل الدخول - بريد مفعل** → الصفحة الرئيسية

## 📝 الأمثلة التعليمية / Educational Examples

### إدارة حالة المصادقة
```dart
StreamBuilder(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data!.emailVerified) {
      return Homepage();
    } else if (snapshot.hasData) {
      return Virefyemail();
    } else {
      return Login();
    }
  }
)
```

### تسجيل الدخول بالبريد
```dart
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email.text,
  password: password.text
);
```

## 🐛 استكشاف الأخطاء وإصلاحها / Troubleshooting

### المشاكل الشائعة / Common Issues

1. **خطأ في تكوين Firebase**
   - تأكد من ملف `google-services.json`
   - تحقق من إعدادات Authentication في Firebase Console

                                                                                                                                                 2. **Google Sign-In لا يعمل**
   - تحقق من بصمة SHA-1
   - تأكد من تكوين OAuth في Firebase

3. **الأيقونات لا تظهر**
   - قم بـ `flutter clean`
   - أعد بناء المشروع

## 🤝 المساهمة / Contributing

نرحب بمساهماتكم! يُرجى:

1. عمل Fork للمشروع
2. إنشاء فرع للميزة الجديدة (`git checkout -b feature/AmazingFeature`)
3. عمل Commit للتغييرات (`git commit -m 'Add some AmazingFeature'`)
                                                                                                              (`git push origin feature/AmazingFeature`)             PUSH  عمل
5. فتح Pull Request

## 📄 الترخيص / License

هذا المشروع مرخص تحت رخصة MIT - انظر ملف [LICENSE](LICENSE) للتفاصيل.

## 👨‍💻 المطور / Developer

تم تطويره كمرجع تعليمي لمطوري Flutter.

Developed as an educational reference for Flutter developers.


---

**⭐ إذا أعجبك هذا المشروع، لا تنسى عمل star للمستودع!**
```
