import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    final textCounter = find.byValueKey('counter');
    final btnIncrement = find.byTooltip('increment');
    final btnSubtract = find.byValueKey("subtract");
    final btnAdd = find.byValueKey("add");
    final txtAlert = find.byValueKey("alert_text");
    final txtAlertTitle = find.text("Alert message !");
    final btnClose = find.byValueKey("close_button");

    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver?.close();
    });

    test('initial counter value starts with 0', () async {
      expect(await driver?.getText(textCounter), "0");
    });

    test('increments the counter', () async {
      await driver?.tap(btnIncrement);
      expect(await driver?.getText(textCounter), "1");

      await driver?.tap(btnIncrement);
      expect(await driver?.getText(textCounter), "2");
    });

    test('decrements the counter', () async {
      await driver?.tap(btnSubtract);
      expect(await driver?.getText(textCounter), "1");

      await driver?.tap(btnSubtract);
      expect(await driver?.getText(textCounter), "0");
    });

    test('dialog pop up', () async {
      await driver?.tap(btnAdd);
      expect(
          await driver?.getText(txtAlert), "Welcome to flutter automation 0");
      expect(await driver?.getText(txtAlertTitle), "Alert message !");
      expect(await driver?.getText(btnClose), "Close");
      await driver?.tap(btnClose);
    });
  });
}
