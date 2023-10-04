#!/usr/bin/env bash
#<xbar.title>Colima Status</xbar.title>
#<xbar.version>v1.0</xbar.version>
#<xbar.author>Ankit Gaurav</xbar.author>
#<xbar.desc>Indicator for Colima instances in menu bar</xbar.desc>
#<swiftbar.refreshOnOpen>true</swiftbar.refreshOnOpen>

export PATH="/usr/local/bin:/usr/bin:$PATH"

function showError() {
  echo "$1"
  exit 1
}
function verifyDependencies() {
  for arg in "$@"; do
    {
      if [ "$(command -v "$arg")" = "" ]; then
        showError "$arg not found. Please install it to use the app"
      fi
    }
  done
}
verifyDependencies colima docker jq

COLIMA_RUNNING_ICON='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'
COLIMA_STOPPED_ICON='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'

colima_list=$(colima list -j)
runningCount=$(echo "$colima_list" | jq '. | select(.status == "Running") | .name' -r | grep -c '')
if [ "$runningCount" -gt 0 ]; then
  echo "| dropdown=false templateImage=$COLIMA_RUNNING_ICON tooltip=Colima is running"
else
  echo "|templateImage=$COLIMA_STOPPED_ICON tooltip=Colima is not running"
fi