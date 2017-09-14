#!/bin/bash

./pull-vagrant-box.sh brad_sickles/coreos 1465.7.0 virtualbox ./boxes/coreos-virtualbox.box
./extract-box.sh ./boxes/coreos-virtualbox.box ./boxes/coreos/virtualbox/
