import 'package:aim_digital_technologies_test_flutter/utils/constants.dart';
import 'package:aim_digital_technologies_test_flutter/view_model/login_cubit.dart';
import 'package:aim_digital_technologies_test_flutter/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitLogOutSuccessState) {
          var snackBar = const SnackBar(
              content: Text(
            Constants.logoutSuccessfully,
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (Route<dynamic> route) => false,
          );
        }

        if (state is LoginCubitLogoutFailureState) {
          var snackBar = SnackBar(content: Text(state.errMsg));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Constants.home),
          actions: [
            IconButton(
              onPressed: () => context.read<LoginCubit>().logOut(),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Column(
          children: [],
        ),
      ),
    );
  }
}
