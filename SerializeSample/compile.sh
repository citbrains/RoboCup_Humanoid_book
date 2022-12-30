#!/bin/sh

#コンパイルするコマンド
g++ serialize.cpp sample.pb.h sample.pb.cc  -I/usr/local/include -L/usr/local/lib -lprotobuf -lprotoc  -o serialize_sample