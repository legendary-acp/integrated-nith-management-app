import 'package:flutter/cupertino.dart';
import 'package:integratednithmanagementapp/services/validator.dart';
import 'package:integratednithmanagementapp/pages/sign_in/signin_manger.dart';

enum EmailFormType { register, signIn }

class EmailModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailModel({
    @required this.manager,
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.submitted = false,
    this.formType = EmailFormType.signIn,
  });

  final SignInManager manager;
  String email;
  String password;
  bool isLoading;
  EmailFormType formType;
  bool submitted;

  String get buttonText {
    return formType == EmailFormType.signIn ? 'Sign in' : 'Register';
  }

  String get bottomText1 {
    return formType == EmailFormType.signIn
        ? 'Need an account?'
        : 'Have an account?';
  }

  String get largeText {
    return formType == EmailFormType.signIn ? 'Login' : 'Register';
  }

  String get smallText {
    return formType == EmailFormType.signIn ? 'Welcome Back' : 'Hey There';
  }

  String get bottomText2 {
    return formType == EmailFormType.signIn ? ' Register' : ' Sign in';
  }

  void toggleFormType() {
    if (formType == EmailFormType.signIn)
      formType = EmailFormType.register;
    else
      formType = EmailFormType.signIn;
    updateWith(
      email: '',
      password: '',
      isLoading: false,
      submitted: false,
      formType: formType,
    );
  }

  void updatePassword(password) => updateWith(password: password);

  void updateEmail(email) => updateWith(email: email);

  void updateWith({
      String email,
      String password,
      bool submitted,
      bool isLoading,
      EmailFormType formType}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.submitted = submitted ?? this.submitted;
    this.isLoading = isLoading ?? this.isLoading;
    this.formType = formType ?? this.formType;
    notifyListeners();
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    final showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    final showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  //Real Work
  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailFormType.signIn) {
        await manager.singInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await manager.createUser(email: email, password: password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      print(e);
    }
  }
}
