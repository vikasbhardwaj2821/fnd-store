// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fnd_store/app/app.dart';
import 'package:fnd_store/modules/dashboard/views/dashboard_view.dart';
import 'package:fnd_store/modules/login/views/login_view.dart';
import 'package:fnd_store/modules/onboarding/views/onboarding_view.dart';
import 'package:fnd_store/modules/select_language/views/select_language_view.dart';
import 'package:fnd_store/modules/splash/views/splash_view.dart';
import 'package:fnd_store/modules/verification/views/verification_view.dart';
import 'package:fnd_store/utils/app_strings.dart';
import 'package:fnd_store/utils/app_translations.dart';

void main() {
  test('provides English and Arabic store translations', () {
    final translations = AppTranslations().keys;

    expect(
      translations['en_US']?[AppStrings.onboardingWelcome],
      'Welcome to F.N.D Store',
    );
    expect(
      translations['ar_AE']?[AppStrings.onboardingWelcome],
      'مرحبًا بك في متجر F.N.D',
    );
    expect(translations['ar_AE']?[AppStrings.next], 'التالي');
    expect(translations['ar_AE']?[AppStrings.skip], 'تخطي');
    expect(translations['ar_AE']?[AppStrings.back], 'رجوع');
    expect(translations['ar_AE']?[AppStrings.getStarted], 'ابدأ الآن');
  });

  testWidgets('shows splash, onboarding, then language selection', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    tester.view.viewPadding = const FakeViewPadding(bottom: 48);
    tester.view.systemGestureInsets = const FakeViewPadding(bottom: 48);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewPadding);
    addTearDown(tester.view.resetSystemGestureInsets);

    await tester.pumpWidget(const FndStoreApp());

    expect(find.byType(SplashView), findsOneWidget);

    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    for (var attempt = 0; attempt < 20; attempt++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      if (find.byType(OnboardingView).evaluate().isNotEmpty) break;
    }
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingView), findsOneWidget);
    expect(find.text('Welcome to F.N.D Store'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Back'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Skip'), findsNothing);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectLanguageView), findsOneWidget);
    expect(find.text('Select Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Arabic'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginView), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('+971'), findsOneWidget);
    expect(find.text('Or continue with'), findsOneWidget);
    expect(find.text('Facebook'), findsNothing);

    await tester.ensureVisible(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(VerificationView), findsOneWidget);
    expect(find.text('Verification Code'), findsOneWidget);
    expect(find.text('Resend in'), findsOneWidget);
    expect(find.text('otp_placeholder'), findsNothing);
    expect(find.byType(TextField), findsNWidgets(4));

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.byType(DashboardView), findsOneWidget);
    expect(find.text('No Delivery Requests Yet!'), findsOneWidget);
    expect(find.text("Today's Bookings"), findsNothing);
    expect(tester.getBottomRight(find.text('Home')).dy, lessThanOrEqualTo(520));
  });
}
