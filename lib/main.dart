import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:saku_walsan_app/app/modules/home/controllers/home_controller.dart';
import 'package:saku_walsan_app/app/modules/spp/controllers/spp_controller.dart';
import 'app/routes/app_pages.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('id_ID', null);
  await GetStorage.init();
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => SppController(), fenix: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
