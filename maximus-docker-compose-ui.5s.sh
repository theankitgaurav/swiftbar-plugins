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

colima_list=$(colima list -j)
runningCount=$(echo "$colima_list" | jq '. | select(.status == "Running") | .name' -r | grep -c '')
if [ "$runningCount" -gt 0 ]; then
  echo "🐳"
  echo "---"
  echo "Colima (running)"
  echo "---"
  running=$(echo "$colima_list" | jq '. | select(.status == "Running") | .name' -r)
  echo "$running"
else
  echo "⚓"
  echo "---"
  echo "Colima (not running)"
fi
