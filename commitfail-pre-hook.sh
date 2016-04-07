#!/bin/bash

echo "Arguments:"
echo $@
echo "---"
FILES_PATTERN='(\..+)?$'
FORBIDDEN='(@?NOCOMMIT|@?COMMITFAIL)'

if ( git diff --cached --name-only | grep -E $FILES_PATTERN | xargs grep -E --with-filename -n $FORBIDDEN ); then
  echo "ERROR: @COMMITFAIL or @NOCOMMIT found. Exiting to save you from yourself."
  exit 1
fi