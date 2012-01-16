#!/bin/bash

cd $(dirname $0)/../test

ALLTESTS=$(echo *-test.sh)

FAILURES=0
PASSES=0

run()
{
  FILE=$1
  TEST=$(echo ${FILE} | sed 's/-test\.sh//')

  printf "%-12s" "${TEST}:"

  STARTTIME=$(date +%s)
  ./${FILE}
  STATUS=$?
  ENDTIME=$(date +%s)
  ELAPSED=$(expr ${ENDTIME} - ${STARTTIME})

  if [ ${STATUS} = "0" ]; then
    echo -n "pass"
    PASSES=$(expr ${PASSES} + 1)
  else
    echo -n "FAIL"
    FAILURES=$(expr ${FAILURES} + 1)
  fi

  echo "  (${ELAPSED}s)"
}

TOTALSTART=$(date +%s)

for file in ${ALLTESTS}
do
  run ${file}
done

TOTALEND=$(date +%s)
TOTALELAPSED=$(expr ${TOTALEND} - ${TOTALSTART})

echo
echo "Duration:" ${TOTALELAPSED}s
echo "Passes:  " ${PASSES}
echo "Failures:" ${FAILURES}

if [ "${FAILURES}" != "0" ]
then
  exit 1
else
  exit 0
fi
