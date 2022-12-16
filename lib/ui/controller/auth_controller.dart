// import '../../model/loading_state.dart';
// import 'base_view_controller.dart';
//
// class AuthController extends BaseViewController {
//
//   LoadingState _loadingState = LoadingInProgress();
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<void> login() async {
//     try {
//       _loadingState = LoadingInProgress();
//       final token = await api.login(
//         email: 'katsutennis.916@gmail.com',
//         password: 'password'
//       );
//       if (token != null && token.isNotEmpty) {
//         _loadingState = LoadingSuccess();
//       } else {
//         _loadingState = LoadingFailure();
//       }
//     } catch (e) {
//       _loadingState = LoadingFailure();
//     }
//   }
// }
