import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:save_water/theme/theme.dart';

const Color marineBlue = primaryColor;

class Authentication extends StatelessWidget {
  const Authentication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(16),
              ),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                marineBlue,
              ),
            ),
          ),
        ),
        home: SignInScreen(
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/waterdrop.png'),
                ),
              );
            },
            sideBuilder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/waterdrop.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to Save Water App! Please sign in to continue.'
                        : 'Welcome to Save Water App! Please create an account to continue',
                  ));
            },
            providerConfigs: const [
              EmailProviderConfiguration(),
            ]));
  }
}
