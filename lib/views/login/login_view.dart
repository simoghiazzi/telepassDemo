import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghiazzi/components/buttons/custom_checkbox.dart';
import 'package:ghiazzi/components/buttons/custom_text_button.dart';
import 'package:ghiazzi/components/fields/custom_text_field.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inserisci le tue credenziali',
                          style: appTextStyles.headingL,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'per accedere al tuo account',
                          style: appTextStyles.headingL,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth;
                        double horizontalPadding;
                        if (constraints.maxWidth < 600) {
                          maxWidth = 400;
                          horizontalPadding = 16;
                        } else if (constraints.maxWidth < 900) {
                          maxWidth = 600;
                          horizontalPadding = 32;
                        } else {
                          maxWidth = 700;
                          horizontalPadding = 0;
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
                                CustomTextField(
                                  label: 'Email',
                                  controller: emailController,
                                  enabled: true,
                                ),
                                const SizedBox(height: 24),
                                CustomTextField(
                                  label: 'Password',
                                  controller: passwordController,
                                  enabled: true,
                                  isPassword: true,
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
                                  children: [
                                    CustomCheckbox(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          rememberMe = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 32),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 150.0,
                                  ),
                                  child: CustomTextButton(
                                    onPressed: () {},
                                    title: 'Accedi',
                                    textStyle: appTextStyles.headingM.copyWith(
                                      color: palette.grey0,
                                    ),
                                    verticalPadding: 8,
                                    isActive: true,
                                    color: palette.primary800,
                                    alignment: MainAxisAlignment.center,
                                  ),
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
