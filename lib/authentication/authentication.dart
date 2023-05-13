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
        /* Change the theme (colors and looks) of 
        widgets (like buttons and input box) */
        theme: ThemeData(
          // Input box style
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          // Button theme
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                // Button size
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
            // Header
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/waterdrop.png'),
                ),
              );
            },

            // Replacement for header in the side when the device is tilted
            sideBuilder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/waterdrop.png'),
                ),
              );
            },

            // Displayed after the heading "Sign in" or "Register"
            subtitleBuilder: (context, action) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to Save Water App! Please sign in to continue.'
                        : 'Welcome to Save Water App! Please create an account to continue',
                  ));
            },
            // },

            // (action)
            providerConfigs: const [
              EmailProviderConfiguration(),
            ]
            // : const [EmailProviderConfiguration()]),
            ));
  }
}
