#!/bin/bash

set -eo pipefail

xcrun altool --upload-app -t ios -f build/ZodiacCasino.ipa -u "$ACC" -p "$PASS" --verbose
