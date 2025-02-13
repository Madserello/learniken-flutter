import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learniken_flutter/src/login/login_screen.dart';
import 'package:learniken_flutter/src/authenticated/authenticated_screen.dart';
import 'package:learniken_flutter/src/profile/profile_screen.dart';
import 'package:learniken_flutter/src/learniken/learniken_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            // Locale('en', ''), // English, no country code
            Locale('no', '')
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(255, 254, 243, 1),
            appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(255, 254, 243, 1),
              centerTitle: true,
            ),
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Color.fromRGBO(240, 245, 223, 1.0),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(240, 245, 223, 1.0),
              selectedItemColor: Colors.black,
            ),
            colorScheme: ColorScheme(
              primary: Color(0xFF283904),
              secondary: Color.fromRGBO(115, 136, 73, 1.0),
              tertiary: Color.fromRGBO(240, 245, 223, 1.0),
              onPrimary: Colors.white,
              onSecondary: Color(0xFF283904),
              onTertiary: Colors.black,
              brightness: Brightness.light,
              error: const Color.fromRGBO(186, 26, 26, 1.0),
              onError: Colors.white,
              surface: const Color.fromRGBO(255, 251, 255, 1.0),
              onSurface: const Color.fromRGBO(32, 26, 26, 1.0),
            ),
            textTheme: GoogleFonts.montserratTextTheme().apply(
                bodyColor: Color(0xFF283904),
                displayColor: Color(0xFF283904),
                decorationColor: Color(0xFF283904)),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case AuthenticatedScreen.routeName:
                    return const AuthenticatedScreen();
                  case ProfileScreen.routeName:
                    return const ProfileScreen();
                  case LearnikenScreen.routeName:
                    return const LearnikenScreen();
                  case LoginScreen.routeName:
                  default:
                    return const LoginScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
