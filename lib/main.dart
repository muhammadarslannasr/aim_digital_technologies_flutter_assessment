import 'package:aim_digital_technologies_test_flutter/repository/repository.dart';
import 'package:aim_digital_technologies_test_flutter/utils/app_colors.dart';
import 'package:aim_digital_technologies_test_flutter/utils/constants.dart';
import 'package:aim_digital_technologies_test_flutter/utils/firebase_keys.dart';
import 'package:aim_digital_technologies_test_flutter/view_model/login_cubit.dart';
import 'package:aim_digital_technologies_test_flutter/views/auth/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: apikey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
          create: (_) => LoginCubit(repo: RepositoryImpl()),
          child: MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return AnnotatedRegion(
                  value: const SystemUiOverlayStyle(
                    statusBarColor: AppColors.gradientSecondColor,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  child: child!,
                );
              },
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                  fontFamily: Constants.fontFamily),
              home: const LoginView()),
        );
      },
    );
  }
}
