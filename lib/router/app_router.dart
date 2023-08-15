import 'package:batnf/features/authentication/presentation/Screens/change_password_screen.dart';
import 'package:batnf/features/authentication/presentation/Screens/email_sent_screen.dart';
import 'package:batnf/features/authentication/presentation/Screens/forgot_password.dart';
import 'package:batnf/features/authentication/presentation/Screens/login_screen.dart';
import 'package:batnf/features/authentication/presentation/Screens/profile_details_screen.dart';
import 'package:batnf/features/authentication/presentation/Screens/registration_screen.dart';
import 'package:batnf/features/home/presentation/screens/contact_us.dart';
import 'package:batnf/features/home/presentation/screens/event_details.dart';
import 'package:batnf/features/home/presentation/screens/home.dart';
import 'package:batnf/features/home/presentation/screens/media_center_details.dart';
import 'package:batnf/features/home/presentation/screens/menu.dart';
import 'package:batnf/features/home/presentation/screens/project_details.dart';
import 'package:batnf/features/home/presentation/widgets/error_widget.dart';
import 'package:batnf/features/onboarding/screens/onboarding_screen.dart';
import 'package:batnf/router/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    // logger.i("This is the route: ${routeSettings.name}");
    switch (routeSettings.name) {
      case Routes.landing:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.emailSent:
        var message = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => EmailSentScreen(message: message),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegistrationScreen(),
        );

      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassword(),
        );

      case Routes.profile:
        var data = routeSettings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ProfileDetailsScreen(
            data: data,
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.contactUs:
        return MaterialPageRoute(
          builder: (_) => const ContactUsScreen(),
        );

      case Routes.mediaItemsCenterDetails:
        var id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MediaCenterDetails(id: id,),
        );

      case Routes.eventDetails:
        var id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EventDetails(id: id,),
        );
      case Routes.projectDetails:
        var id = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProjectDetails(id: id,),
        );

      case Routes.menu:
        return MaterialPageRoute(
          builder: (_) => const MenuScreen(),
        );
      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePassword(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ErrorScreen(),
        );
    }
  }
}
