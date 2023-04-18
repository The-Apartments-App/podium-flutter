part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.countryCode = 'United States (+1)',
    this.phoneNumber = '',
    this.smsCode = '',
    this.verificationId = '',
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.emailIsEntered = false,
    this.phoneIsEntered = false,
  });

  final Email email;
  final String countryCode;
  final String phoneNumber;
  final String smsCode;
  final String verificationId;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;
  final bool emailIsEntered;
  final bool phoneIsEntered;

  @override
  List<Object> get props => [
        email,
        password,
        countryCode,
        phoneNumber,
        smsCode,
        verificationId,
        status,
        emailIsEntered,
        phoneIsEntered
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    String? countryCode,
    String? phoneNumber,
    String? smsCode,
    String? verificationId,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? emailIsEntered,
    bool? phoneIsEntered,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      smsCode: smsCode ?? this.smsCode,
      verificationId: verificationId ?? this.verificationId,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      emailIsEntered: emailIsEntered ?? this.emailIsEntered,
      phoneIsEntered: phoneIsEntered ?? this.phoneIsEntered,
    );
  }
}
