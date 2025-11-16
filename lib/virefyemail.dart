import 'package:authenticaion_app/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Virefyemail extends StatefulWidget {
  const Virefyemail({Key? key}) : super(key: key);

  @override
  State<Virefyemail> createState() => _VirefyemailState();
}

class _VirefyemailState extends State<Virefyemail> {
  bool _isLoading = false;
  bool _isSending = false;

  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  sendverifylink() async {
    setState(() {
      _isSending = true;
    });
    
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      
      Get.snackbar(
        'تم الإرسال',
        'تم إرسال رابط التحقق إلى بريدك الإلكتروني',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في إرسال رابط التحقق: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  reload() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser!;
      
      if (user.emailVerified) {
        Get.offAll(const Wrapper());
      } else {
        Get.snackbar(
          'لم يتم التحقق بعد',
          'يرجى التحقق من بريدك الإلكتروني أولاً',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'فشل في التحديث: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "التحقق من البريد الإلكتروني",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0),
            
            // الأيقونة الرئيسية
            Icon(
              Icons.mark_email_unread_outlined,
              size: 100,
              color: Colors.blue,
            ),
            
            const SizedBox(height: 32.0),
            
            // العنوان
            const Text(
              "التحقق من البريد الإلكتروني",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16.0),
            
            // النص التوضيحي
            const Text(
              "يجب التحقق من بريدك الإلكتروني للمتابعة",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 40.0),
            
            // بطاقة التعليمات
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8.0),
                      Text(
                        "خطوات التحقق",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16.0),
                  
                  // خطوات التحقق
                  _buildStep(1, "افتح بريدك الإلكتروني"),
                  _buildStep(2, "ابحث عن رسالة التحقق منا"),
                  _buildStep(3, "انقر على رابط التحقق في الرسالة"),
                  _buildStep(4, "ارجع للتطبيق وانقر على زر التحديث"),
                ],
              ),
            ),
            
            const SizedBox(height: 30.0),
            
            // زر إعادة إرسال الرابط
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isSending ? null : sendverifylink,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  side: BorderSide(color: Colors.blue),
                ),
                child: _isSending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send),
                          SizedBox(width: 8.0),
                          Text(
                            'إعادة إرسال رابط التحقق',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            const SizedBox(height: 16.0),
            
            // زر التحديث
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : reload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh),
                          SizedBox(width: 8.0),
                          Text(
                            'تحديث الحالة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            const SizedBox(height: 20.0),
            
            // ملاحظة
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Column(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  SizedBox(height: 8.0),
                  Text(
                    "ملاحظة: بعد النقر على رابط التحقق في بريدك الإلكتروني، ارجع للتطبيق وانقر على زر 'تحديث الحالة'",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لبناء خطوة من خطوات التحقق
  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}







