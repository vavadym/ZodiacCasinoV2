#!/bin/bash

set -eo pipefail

xcodebuild -workspace ZodiacCasino.xcworkspace \
            -scheme ZodiacCasino \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/ZodiacCasino.xcarchive \
            clean archive | xcpretty
