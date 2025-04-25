#!/bin/bash

while true; do
    # Gen random numbers
    BUCKET_NUM=$(( (RANDOM % 10) + 1 ))
    OBJ_NUM=$(( (RANDOM % 1000000) + 1 ))
    BLOB_NUM=$(( (RANDOM % 3) + 1 ))

    #put to buckets
    /usr/local/bin/mc put "blob${BLOB_NUM}.txt" minio1/bucket${BUCKET_NUM}/file${OBJ_NUM}.bin
    sleep 30
done;
