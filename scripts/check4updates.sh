#!/bin/sh

euscan -q `EIX_LIMIT=0 eix --in-overlay elementary --only-names | grep -v pantheon`
