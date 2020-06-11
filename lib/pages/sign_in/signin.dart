// Description: Login Screen for the app

/*
* For Future:
* If you want to take more fields during registration add condition for them
* and then use logic in submit button code
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:integratednithmanagementapp/custom_widget/bold_text.dart';
import 'package:integratednithmanagementapp/custom_widget/custom_button.dart';
import 'package:integratednithmanagementapp/custom_widget/small_text.dart';
import 'package:integratednithmanagementapp/services/auth.dart';
import 'package:integratednithmanagementapp/pages/sign_in/signin_manger.dart';
import 'package:integratednithmanagementapp/model/signin_model.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({@required this.manager, @required this.model});

  final SignInManager manager;
  final model;

  // To create this widgets
  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    final SignInManager manager = SignInManager(auth: auth);
    return ListenableProvider<EmailModel>(
      create: (_) => EmailModel(manager: manager),
      child: Consumer<EmailModel>(
          builder: (context, model, _) => SignIn(
                manager: manager,
                model: model,
              )),
    );
  }

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  void _emailEditingComplete() {
    final newFocus = widget.model.emailValidator.isValid(widget.model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  TextField _buildEmailField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.alternate_email),
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading == false,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        labelText: 'Password',
        errorText: widget.model.passwordErrorText,
        enabled: widget.model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.model.updatePassword,
      onEditingComplete: _submit,
    );
  }

  void _register(BuildContext context) {
    _emailController.clear();
    _passwordController.clear();
    /*Navigator.of(context).push(CupertinoPageRoute<void>(
      builder: (context) => Register.create(context),
    ));*/
    widget.model.toggleFormType();
  }

  void _submit() async {
    await widget.model.submit();
  }

  Widget _buildLogin(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LargeText(
          text: widget.model.largeText,
          paddingTop: 100,
        ),
        SmallText(
          text: widget.model.smallText,
          paddingTop: 0,
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  widget.model.isLoading
                      ? SpinKitFadingCircle(
                          color: Colors.indigo,
                          size: 50.0,
                        )
                      : SizedBox(
                          height: 30,
                        ),
                  Container(
                    padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        _buildEmailField(),
                        _buildPasswordTextField(),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 30.0),
                      child: CustomButton(
                        pressed: widget.model.canSubmit ? _submit : null,
                        text: widget.model.buttonText,
                        bgColor: Color(0xFF594CFC),
                        textColor: Colors.white,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.model.bottomText1,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF1034A6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        child: Text(
                          widget.model.bottomText2,
                          style: TextStyle(
                              color: Color(0xFF594CFC),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () => _register(context),
                      )
                    ],
                  ),
                  if (widget.model.formType == EmailFormType.signIn)
                    Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Center(
                          child: Text(
                            'or',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomButton(
                              pressed: () =>
                                  widget.manager.signInWithFacebook(),
                              imageURL: 'assets/img/facebook-logo.png',
                              bgColor: Color(0xFFF5F5F5),
                              radius: 50.0,
                              heightImage: 40.0,
                              height: 50.0,
                              width: 50.0,
                            ),
                            CustomButton(
                              pressed: () => widget.manager.signInWithGoogle(),
                              imageURL: 'assets/img/google-logo.png',
                              radius: 50.0,
                              width: 40.0,
                              heightImage: 40.0,
                            ),
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xFF594CFC),
          Color(0xFF61D8FA),
          Color(0xFF9EF3C9)
        ])),
        child: _buildLogin(context),
      ),
    );
  }
}
