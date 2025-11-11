# دليل بناء تطبيق TikBoost Pro - APK

## الطريقة الأسهل: استخدام Codemagic (بدون خبرة تقنية)

### الخطوة 1: إنشاء حساب GitHub (مجاني)
1. اذهب إلى https://github.com
2. اضغط "Sign up" (التسجيل)
3. أكمل خطوات التسجيل البسيطة

### الخطوة 2: رفع المشروع إلى GitHub
1. في صفحة GitHub الرئيسية، اضغط "New" (جديد)
2. أعط المشروع اسم: `tikboost-pro`
3. اختر "Public" (عام)
4. اضغط "Create repository"
5. اتبع التعليمات لرفع ملفات المشروع

### الخطوة 3: إنشاء حساب Codemagic (مجاني)
1. اذهب إلى https://codemagic.io
2. اضغط "Sign Up" واختر "Sign up with GitHub"
3. وافق على الأذونات

### الخطوة 4: ربط المشروع بـ Codemagic
1. في لوحة Codemagic، اضغط "Add application"
2. اختر المشروع `tikboost-pro`
3. اضغط "Start building"

### الخطوة 5: تحميل APK
1. انتظر انتهاء البناء (عادة 10-15 دقيقة)
2. اضغط على "Artifacts" (المخرجات)
3. حمّل ملف `app-release.apk`

### الخطوة 6: نشر التطبيق
يمكنك الآن:
- **مشاركة APK مباشرة** مع الأصدقاء
- **نشره على Google Play Store** (يتطلب حساب مطور بـ 25 دولار لمرة واحدة)
- **استخدام متجر تطبيقات بديل** مثل APKPure أو F-Droid

---

## الطريقة الثانية: بناء محلي على جهازك (للمتقدمين)

إذا كان لديك Java و Android SDK مثبتة:

```bash
flutter pub get
flutter build apk --release
```

سيتم إنشاء ملف APK في: `build/app/outputs/flutter-apk/app-release.apk`

---

## معلومات التطبيق
- **الاسم:** TikBoost Pro
- **الإصدار:** 1.0.0
- **الحد الأدنى لـ Android:** 5.0 (API 21)

## الدعم
إذا واجهت أي مشكلة، تواصل معي!
