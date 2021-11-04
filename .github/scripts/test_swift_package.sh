#!/bin/bash

set -eo pipefail

cd ZodiacCasino-package; swift test --parallel; cd ..
