#!/bin/sh

kill -9 `ps auxw | awk '/raspivid/ && !/awk/{print $2}'`
