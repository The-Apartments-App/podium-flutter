# Podium

There are not many things set in stone at Podium. We encourage you to explore, investigate, and suggest new things. Never be afraid to be ambitious!

## Wiki Links 📑
- [User Stories](https://github.com/Podium-Apartments/master_repo/wiki/User-Stories)

## Getting Started 🚀

This project contains 3 flavors:
(Disclaimer: these different flavors aren't much different. The expectation is for these flavors to become environments.)

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Podium works on iOS, Android, Web, and Windows._

---

## GitHub Notes

Current Test Coverage: 4.89%

Clone down the master_repo, and create branches from here. Once your code is ready for review, push it up, and create a Pull Request. Message me on Slack once you have created the Pull Request and I will get to reviewing it as soon as possible.

Branch Names should follow this format `[your initials]/[todays-date]/[scope-of-your-branch]` --> `DV/4-25-23/update-readme`

Pull down the master branch before submitting a PR to ensure you have the most recent changes.

Be sure to run `dart format` to get your changes to pass the workflow checks.

When writing tests, using the file naming convention `*_test.dart` e.g. `waitlist_button_test.dart`, otherwise the test package may not run your tests.

- Current Test Coverage: 32.28%


