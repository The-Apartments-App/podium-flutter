import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginPhoneCodeInput extends StatefulWidget {
  const LoginPhoneCodeInput({super.key});

  @override
  State<LoginPhoneCodeInput> createState() => _LoginPhoneCodeInputState();
}

class _LoginPhoneCodeInputState extends State<LoginPhoneCodeInput> {
  @override
  void initState() {
    super.initState();
  }

  bool obscureTextSet = true;
  bool showError = false;

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<LoginCubit, LoginState>(
  //     buildWhen: (previous, current) => previous.password != current.password,
  //     builder: (context, state) {
  //       return Padding(
  //         padding: const EdgeInsets.all(2),
  //         child: TextField(
  //           key: const Key('loginFormLoginpasswordInput_textField'),
  //           onChanged: (password) {
  //             context.read<LoginCubit>().passwordChanged(password);
  //             setState(() {
  //               showError = false;
  //             });
  //           },
  //           onEditingComplete: () {
  //             setState(() {
  //               showError = true;
  //             });
  //           },
  //           obscureText: obscureTextSet,
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderSide: const BorderSide(
  //                 color: Colors.grey,
  //               ),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             labelText: 'Password',
  //             errorText: state.password.isNotValid && showError
  //                 ? 'invalid password'
  //                 : null,
  //             suffixIcon: TextButton(
  //               child: Text(
  //                 obscureTextSet ? 'Show' : 'Hide',
  //                 style: const TextStyle(
  //                   decoration: TextDecoration.underline,
  //                   decorationThickness: 1.5,
  //                 ),
  //               ),
  //               onPressed: () => {
  //                 setState(() {
  //                   obscureTextSet = !obscureTextSet;
  //                 })
  //               },
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLength: 6,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        counterText: '',
        hintText: 'SMS code',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) => {context.read<LoginCubit>().smsCodeChanged(value)},
    );
  }
}
