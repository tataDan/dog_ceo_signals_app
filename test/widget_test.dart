import 'package:dog_ceo_signals_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the home page', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Home Page'), findsOneWidget);
    expect(find.text('Go to the Random Dog screen'), findsOneWidget);
    expect(find.text('Go to the Show Breed Photos screen'), findsOneWidget);
  });
}
