import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podium/src/login/login.dart';

class LoginEmailInput extends StatefulWidget {
  const LoginEmailInput({super.key});

  @override
  State<LoginEmailInput> createState() => LoginEmailInputState();
}

class LoginEmailInputState extends State<LoginEmailInput> {
  bool showError = false;
  bool focused = false;
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showError = false;
          focused = true;
        });
      } else {
        setState(() {
          showError = true;
          focused = false;
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(_handleFocusChange)
      // The attachment will automatically be detached in dispose().
      ..dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus != focused) {
      setState(() {
        focused = focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width >= 750
              ? 670
              : MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextField(
                focusNode: focusNode,
                style: const TextStyle(height: 1.5),
                key: const Key('loginFormLoginEmailInput_textField'),
                onChanged: (email) {
                  context.read<LoginCubit>().emailChanged(email);
                  setState(() {
                    showError = false;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    showError = true;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Email',
                  errorText: state.email.isNotValid && showError ? '' : null,
                ),
              ),
              if (state.email.isNotValid && showError)
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.error, size: 20, color: Colors.red[700]),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Email is required.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red[700],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
