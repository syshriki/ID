INC=lib
PERL=/usr/bin/perl
TEST=undefined

all:
	${PERL} -I${INC} -e 'use Test::Harness; runtests @ARGV;' `find . -name "*.t" -print | sort `

test: 
	${PERL} -I${INC} ${TEST}
