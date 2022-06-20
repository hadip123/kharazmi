import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('راهنمای برنامه'),
        ),
        body: Html(data: '''
<div class="container pa-3" dir="rtl" style="text-align: right; text-direction: ;">
    <h3 style="color: blue;">
      راهنمای استفاده از اپلیکیشن
    </h3>

    <h4 class="pt-10">نوشتن نوشته</h4>
    <ol>
      <li>منو کشویی را باز کنید و وارد قسمت تنظیمات شوید.</li>
      <li>
        اگر وارد شده اید، به مرحله بعدی بروید اگه نشده اید روی ثبت نام یا ورود
        بزنید و مراحل را طی
      </li>
      <li>وارد صفحه یکی از استان ها شوید</li>
      <li>سپس روی دکمه سمت چپ پایین بزنید</li>
      <li>مراحل نوشتن را بگذرانید و دکمه سمت راست پایین را بزنید</li>
    </ol>
    <h4 class="pt-10">نظر دادن بر روی نوشته ها</h4>
    <ol>
      <li>وارد صفحه نوشته مورد نظر می شوید</li>
      <li>
        اگر وارد شده اید گزینه افزودن نظر برای شما فعال است و می توانید نظر
        بدهید
      </li>
    </ol>
    <h4 class="pt-10">امتیازدهی نوشته ها</h4>
    <ol>
      <li>وارد صفحه نوشته مورد نظر می شوید</li>
      <li>
        بدون حساب کاربری هم قسمت امتیازدهی برای شما فعال است و می توانید امتیاز
        بدهید
      </li>
    </ol>
  </div>



'''));
  }
}
