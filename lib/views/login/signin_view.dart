import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/components/buttons/custom_checkbox.dart';
import 'package:ghiazzi/components/buttons/custom_text_button.dart';
import 'package:ghiazzi/components/fields/custom_text_field.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/viewmodels/signin_view_model.dart';
import 'package:go_router/go_router.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _LoginViewState();
}

class _LoginViewState extends State<SigninView> {
  bool activeTextfields = true;

  bool termsAccepted = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late SigninViewModel signinViewModel;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    signinViewModel = context.read<SigninViewModel>();

    // Initialize controllers with data from authData if available
    final email = signinViewModel.authData?['email'];
    final password = signinViewModel.authData?['username'];

    emailController.text = email ?? '';
    passwordController.text = password ?? '';
  }

  void validateEmail(String email) {
    final isValid = signinViewModel.checkEmail(email);
    setState(() {
      isEmailValid = isValid;
    });
  }

  void validatePassword(String password) {
    final isValid = signinViewModel.checkPassword(password);
    setState(() {
      isPasswordValid = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: palette.primary800,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Image.asset('assets/images/logo.png', height: 44),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth;
                        double horizontalPadding;
                        if (constraints.maxWidth < 600) {
                          maxWidth = 300;
                          horizontalPadding = 10;
                        } else if (constraints.maxWidth < 900) {
                          maxWidth = 500;
                          horizontalPadding = 30;
                        } else {
                          maxWidth = 600;
                          horizontalPadding = 50;
                        }
                        return Center(
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Inserisci le tue credenziali',
                                      style: appTextStyles.headingL,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      'per accedere al tuo account',
                                      style: appTextStyles.headingL,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                CustomTextField(
                                  label: 'Email',
                                  controller: emailController,
                                  enabled: activeTextfields,
                                  onChanged: (value) => validateEmail(value),
                                  isChecked: isEmailValid,
                                ),
                                const SizedBox(height: 24),
                                CustomTextField(
                                  label: 'Password',
                                  controller: passwordController,
                                  enabled: activeTextfields,
                                  isPassword: true,
                                  onChanged: (value) => validatePassword(value),
                                  isChecked: isPasswordValid,
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Password dimenticata?',
                                            style: appTextStyles.linkS.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  palette.primary500,
                                            ),
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomCheckbox(
                                      value: termsAccepted,
                                      onChanged: (value) {
                                        setState(() {
                                          termsAccepted = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Ho preso visione del ',
                                              style: appTextStyles.paragraphS,
                                            ),
                                            TextSpan(
                                              text: 'Foglio Informativo',
                                              style: appTextStyles.linkS
                                                  .copyWith(
                                                    color: palette.primary500,
                                                  ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap = () {},
                                            ),
                                            TextSpan(
                                              text: ', ',
                                              style: appTextStyles.paragraphS,
                                            ),
                                            TextSpan(
                                              text: 'Documento di Sintesi ',
                                              style: appTextStyles.linkS
                                                  .copyWith(
                                                    color: palette.primary500,
                                                  ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap = () {},
                                            ),
                                            TextSpan(
                                              text: 'e ',
                                              style: appTextStyles.paragraphS,
                                            ),
                                            TextSpan(
                                              text: 'Norme e Condizioni, ',
                                              style: appTextStyles.linkS
                                                  .copyWith(
                                                    color: palette.primary500,
                                                  ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap = () {},
                                            ),
                                            TextSpan(
                                              text: 'nonché dell\'',
                                              style: appTextStyles.paragraphS,
                                            ),
                                            TextSpan(
                                              text: 'informativa della Privacy',
                                              style: appTextStyles.linkS
                                                  .copyWith(
                                                    color: palette.primary500,
                                                  ),
                                              recognizer:
                                                  TapGestureRecognizer()
                                                    ..onTap = () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                BlocConsumer<SigninViewModel, SigninState>(
                                  bloc: signinViewModel,
                                  listener: (context, state) {
                                    if (state is SigninSuccess) {
                                      context.push('/home');
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is SigninLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: palette.primary600,
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: horizontalPadding,
                                        ),
                                        child: CustomTextButton(
                                          onPressed: () {
                                            if (isEmailValid &&
                                                isPasswordValid &&
                                                termsAccepted) {
                                              signinViewModel.signin();
                                              setState(() {
                                                activeTextfields = false;
                                              });
                                            }
                                          },
                                          title: 'Accedi',
                                          textStyle: appTextStyles.headingM
                                              .copyWith(color: palette.grey0),
                                          verticalPadding: 8,
                                          isActive:
                                              isEmailValid &&
                                              isPasswordValid &&
                                              termsAccepted,
                                          color: palette.primary800,
                                          alignment: MainAxisAlignment.center,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Non hai un account? ',
                                          style: appTextStyles.paragraphM
                                              .copyWith(color: palette.grey400),
                                        ),
                                        TextSpan(
                                          text: 'Registrati',
                                          style: appTextStyles.paragraphM
                                              .copyWith(
                                                color: palette.primary500,
                                              ),
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: palette.primary1000,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logo.png', height: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Sede legale: Via Laurentina, 449 - 00142 Roma (RM)\nP.IVA 09771701001 - Certificato ISO9001 e ISO27001',
                    style: appTextStyles.paragraphS.copyWith(
                      color: palette.grey400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ), // end footer Container
          ], // end children of main Column
        ), // end Column (body)
      ), // end SafeArea
    ); // end Scaffold
  }
}
