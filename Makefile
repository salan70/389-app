.PHONY: setup
setup:
	fvm flutter clean
	fvm flutter pub get

.PHONY: generate
generate:
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs

.PHONY: test
test:
	fvm flutter test --coverage
	lcov --remove coverage/lcov.info '*.freezed.dart' '*.g.dart' '*/repository*' -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/html
	open /Users/odatetsuo/Projects/teigi_app/coverage/html/index.html
