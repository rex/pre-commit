#!/bin/bash

# COMMITFAIL
#
#   - Fail to push to the remote if any of the following strings are found:
#       - @COMMITFAIL
#       - COMMITFAIL
#       - @NOCOMMIT
#       - NOCOMMIT

set -e

remote="$1"
url="$2"
KEY="[@commitfail pre-push]"

echo "$KEY REMOTE: $remote"
echo "$KEY URL: $url"

while read local_ref local_sha remote_ref remote_sha
do
  echo "$KEY LOCAL_REF: $local_ref"
  echo "$KEY LOCAL_SHA: $local_sha"
  echo "$KEY REMOTE_REF: $remote_ref"
  echo "$KEY REMOTE_SHA: $remote_sha"

  if ( git diff --no-renames "$remote_sha..$local_sha" | grep -E '^\+.+' | grep -H -E '@?COMMITFAIL|@?NOCOMMIT' ); then
    echo "$KEY Found COMMITFAIL, exiting"
    exit 1
  else
    echo "$KEY No COMMITFAIL found, allowing push to take place"
  fi
done
