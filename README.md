# Tourism - Travel App

تطبيق سفر لتركيا يتكون من Backend (Django REST Framework) و Frontend (Flutter).

## 🏗️ البنية

### Backend (Django)
- **المشروع الرئيسي**: `tourism_backend`
- **التطبيقات**:
  - `accounts`: إدارة المستخدمين والملفات الشخصية
  - `places`: إدارة الأماكن والمدن والفئات والمراجعات والمنشورات

### Frontend (Flutter)
- **المشروع**: `tourism_app`
- **البنية**: Clean Architecture مع Riverpod لإدارة الحالة

## 🚀 البدء السريع

### متطلبات النظام
- Python 3.11+
- Flutter SDK 3.8.1+
- Django 5.2.8
- Django REST Framework 3.16.1

### إعداد Backend

1. إنشاء بيئة افتراضية:
```bash
python -m venv backend_env
```

2. تفعيل البيئة الافتراضية:
```bash
# Windows
backend_env\Scripts\activate

# Linux/Mac
source backend_env/bin/activate
```

3. تثبيت التبعيات:
```bash
pip install -r requirements.txt
```

4. تشغيل Migrations:
```bash
python manage.py migrate
```

5. إنشاء مستخدم superuser:
```bash
python manage.py createsuperuser
```

6. تشغيل الخادم:
```bash
python manage.py runserver
```

الخادم سيعمل على: `http://127.0.0.1:8000`

### إعداد Flutter App

1. الانتقال إلى مجلد التطبيق:
```bash
cd tourism_app
```

2. تثبيت التبعيات:
```bash
flutter pub get
```

3. تشغيل التطبيق:
```bash
flutter run
```

## 📡 API Endpoints

### Accounts
- `GET /api/accounts/me/` - معلومات المستخدم الحالي

### Places
- `GET /api/cities/` - قائمة المدن
- `GET /api/categories/` - قائمة الفئات
- `GET /api/places/` - قائمة الأماكن (مع فلترة: `?city=slug&category=slug&search=query`)
- `GET /api/reviews/` - قائمة المراجعات
- `GET /api/posts/` - قائمة المنشورات

## 🗄️ قاعدة البيانات

المشروع يستخدم SQLite في التطوير. قاعدة البيانات موجودة في: `db.sqlite3`

### النماذج الرئيسية:
- **UserProfile**: ملف المستخدم
- **City**: المدن
- **Category**: فئات الأماكن
- **Place**: الأماكن السياحية
- **PlaceImage**: صور الأماكن
- **Review**: مراجعات المستخدمين
- **Post**: منشورات المستخدمين

## 🛠️ التقنيات المستخدمة

### Backend
- Django 5.2.8
- Django REST Framework 3.16.1
- SQLite

### Frontend
- Flutter 3.8.1
- Riverpod 2.5.0 (State Management)
- Dio 5.0.0 (HTTP Client)

## 📝 ملاحظات

- قاعدة البيانات `db.sqlite3` مستبعدة من Git
- البيئة الافتراضية `backend_env/` مستبعدة من Git
- ملفات البناء `build/` مستبعدة من Git

## 📄 الترخيص

هذا المشروع خاص.

