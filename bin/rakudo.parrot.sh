#!/bin/sh

# default to sysperl
PATH=/usr/local/bin:$PATH

rm -rf rakudo.parrot
git clone repos/rakudo.git rakudo.parrot
git clone repos/nqp.git rakudo.parrot/nqp
git clone repos/parrot.git rakudo.parrot/parrot
git clone repos/roast.git rakudo.parrot/t/spec
cd rakudo.parrot
perl Configure.pl --backends=parrot --gen-parrot
make all

# uninstalled rakudo doesn't know how to find Test.pm
# ... or any other modules
export PERL6LIB=`pwd`/lib:.

# some tests require a LANG.
export LANG=en_US.UTF-8

perl t/spec/test_summary rakudo.parrot 2>&1 | tee ../log/rakudo.parrot_summary.out
