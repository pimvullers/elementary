#!/usr/bin/perl
# Fix the relink_command field of .la files in the specified directory tree
# to add "-L$dir/.libs" for every .la file that is specified in a relative
# $dir; place these new -L directives before the first relative .la file.
#
# E.g. :
# relink_command="(cd /tmp/foo/libfoo; /bin/sh /tmp/foo/libtool --silent --tag CC --mode=relink gcc -O2 foo.lo bar/libbar.la ../baz/libbaz.la /usr/lib/libfrob.la -lm)"
# will become
# relink_command="(cd /tmp/foo/libfoo; /bin/sh /tmp/foo/libtool --silent --tag CC --mode=relink gcc -O2 foo.lo -Lbar/.libs -L../baz/.libs bar/libbar.la ../baz/libbaz.la /usr/lib/libfrob.la -lm)"
#
# Such a procedure should ensure that during relinking, libraries in the
# local build tree will be looked at before libraries installed systemwide.
#
# Limitations: it is assumed that relink_command is one line. It is assumed
# that any spaces in paths are escaped using '\'.
#
# Copyright (c) 2011 Alexandre Rostovtsev <tetromino@gmail.com>
#
# This program is free software; you can redistribute it and/or modify it 
# under the same terms as Perl itself.
use strict;
use warnings;

use Cwd qw(realpath);
use File::Basename;
use File::Find;

my %processed = ();
sub process_la_file {
    my $filename = $_; # relative to cwd
    my $pretty_filename = $File::Find::name; # relative to initial cwd
    if (-d $filename) { return; }

    # don't process a single .la file multiple times (e.g. if symlinked)
    my $realpath = realpath($filename);
    if ($processed{$realpath}) {
        print "$pretty_filename ($realpath) was already processed\n";
	return;
    } else {
        $processed{$realpath}++;
    }

    # preserve the .la file's mtime in order to avoid triggering make rules
    my $mtime = (stat $filename)[9];
    open(my $fh, '<', $filename) or die $!;
    my $text;
    my $changes; # whether the file has been changed
    while (<$fh>) {
        if (/relink_command=/) {
            my ($start, $added, $end);
	    my $ignore = 0; # number of words to not check for similariy to
	                    # an .la filename, following and including the
                            # current word
	    # split by unescaped spaces
	    for my $word (split /(?<!\\) /) {
	        if ($word =~ /^-/) {
                    # ignore command-line options; ignore filename after -o
                    $ignore++;
                    $ignore++ if $word eq '-o' ;
                }
	    	if ($word =~ m:^[^/].*\.la\W*$: and not $ignore) {
                    $added .= "-L" . dirname($word) . "/.libs ";
                    $end .= "$word ";
                    $changes++;
                } else {
                    if ($end) {
                        $end .= "$word ";
                    } else {
                        $start .= "$word ";
                    }
                }
                $ignore-- if $ignore > 0;
	    }
	    $_ = "$start$added$end";
            print "Added '$added' to relink_command in $pretty_filename\n" if $changes;
	}
	$text .= $_;
    }
    close $fh;
    if ($changes) {
        open($fh, '>', $filename) or die $!;
        print $fh $text;
        close $fh;
        # Perl's utime does not support sub-second time :/
        # And Time::HiRes doesn't help. As a workaround, round up the number of
        # seconds in order to avoid triggering make rules.
        utime $mtime + 1, $mtime + 1, $filename;
    }
}

if (not @ARGV or $ARGV[0] eq '-h' or $ARGV[0] eq '--help') {
    warn <<endhelp;
Usage: fix_relink_command.pl [LAFILENAMES or DIRECTORIES]

Adds extra -L\$dir/.libs arguments to the relink_command field of .la files
in order to ensure that during relinking, libraries in the local build tree
will be looked at before ones installed systemwide.

If a filename is given, will process that .la file. If a directory is given,
will recursively process all .la files in it (but will not recurse into
symlinked or hidden directories).
endhelp
    exit;
}

find({ wanted => \&process_la_file,
       preprocess => sub {grep { if (-d $_) { /^[^.]/ } else { /\.la$/ } } sort @_}
     }, @ARGV);
