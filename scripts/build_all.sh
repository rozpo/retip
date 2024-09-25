#!/bin/sh

flutter build apk --debug
flutter build apk --profile
flutter build apk --release

flutter install --debug
flutter install --profile
flutter install --release
