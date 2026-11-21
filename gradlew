#!/usr/bin/env sh
set -eu

GRADLE_VERSION="8.9"
BASE_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
CACHE_DIR="${HOME}/.gradle/bootstrap/${GRADLE_VERSION}"
DIST="${CACHE_DIR}/gradle-${GRADLE_VERSION}-bin.zip"
GRADLE_HOME="${CACHE_DIR}/gradle-${GRADLE_VERSION}"

if [ ! -x "${GRADLE_HOME}/bin/gradle" ]; then
  mkdir -p "${CACHE_DIR}"
  if [ ! -f "${DIST}" ]; then
    echo "Downloading Gradle ${GRADLE_VERSION}..."
    curl -L --fail --retry 3 -o "${DIST}"           "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
  fi
  rm -rf "${GRADLE_HOME}"
  unzip -q "${DIST}" -d "${CACHE_DIR}"
fi

exec "${GRADLE_HOME}/bin/gradle" -p "${BASE_DIR}" "$@"
