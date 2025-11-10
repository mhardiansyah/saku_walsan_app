import 'package:get/get.dart';

import '../modules/detail_berita/bindings/detail_berita_binding.dart';
import '../modules/detail_berita/views/detail_berita_view.dart';
import '../modules/detail_notifikasi/bindings/detail_notifikasi_binding.dart';
import '../modules/detail_notifikasi/views/detail_notifikasi_view.dart';
import '../modules/detail_riwayat/bindings/detail_riwayat_binding.dart';
import '../modules/detail_riwayat/views/detail_riwayat_view.dart';
import '../modules/detail_riwayat_transaksi/bindings/detail_riwayat_transaksi_binding.dart';
import '../modules/detail_riwayat_transaksi/views/detail_riwayat_transaksi_view.dart';
import '../modules/forgotpassword/bindings/forgotpassword_binding.dart';
import '../modules/forgotpassword/views/forgotpassword_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/isi_data_siswa/bindings/isi_data_siswa_binding.dart';
import '../modules/isi_data_siswa/views/isi_data_siswa_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/method_pembayaran/bindings/method_pembayaran_binding.dart';
import '../modules/method_pembayaran/views/method_pembayaran_view.dart';
import '../modules/midtrans_payment/bindings/midtrans_payment_binding.dart';
import '../modules/midtrans_payment/views/midtrans_payment_view.dart';
import '../modules/nominal/bindings/nominal_binding.dart';
import '../modules/nominal/views/nominal_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/regsiter_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resent_password/bindings/resent_password_binding.dart';
import '../modules/resent_password/views/resent_password_view.dart';
import '../modules/riwayat_hutang/bindings/riwayat_hutang_binding.dart';
import '../modules/riwayat_hutang/views/riwayat_hutang_view.dart';
import '../modules/riwayat_transaksi/bindings/riwayat_transaksi_binding.dart';
import '../modules/riwayat_transaksi/views/riwayat_transaksi_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/spp/bindings/spp_binding.dart';
import '../modules/spp/views/spp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotpasswordView(),
      binding: ForgotpasswordBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_TRANSAKSI,
      page: () => const RiwayatTransaksiView(),
      binding: RiwayatTransaksiBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ISI_DATA_SISWA,
      page: () => const IsiDataSiswaView(),
      binding: IsiDataSiswaBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESENT_PASSWORD,
      page: () => const ResentPasswordView(),
      binding: ResentPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT,
      page: () => const DetailRiwayatView(),
      binding: DetailRiwayatBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_NOTIFIKASI,
      page: () => const DetailNotifikasiView(),
      binding: DetailNotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_HUTANG,
      page: () => const RiwayatHutangView(),
      binding: RiwayatHutangBinding(),
    ),
    GetPage(
      name: _Paths.NOMINAL,
      page: () => NominalView(),
      binding: NominalBinding(),
    ),
    GetPage(
      name: _Paths.MIDTRANS_PAYMENT,
      page: () => const MidtransPaymentView(),
      binding: MidtransPaymentBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BERITA,
      page: () => const DetailBeritaView(),
      binding: DetailBeritaBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT_TRANSAKSI,
      page: () => const DetailRiwayatTransaksiView(),
      binding: DetailRiwayatTransaksiBinding(),
    ),
    GetPage(
      name: _Paths.SPP,
      page: () => const SppView(),
      binding: SppBinding(),
    ),
    GetPage(
      name: _Paths.METHOD_PEMBAYARAN,
      page: () => const MethodPembayaranView(),
      binding: MethodPembayaranBinding(),
    ),
  ];
}
