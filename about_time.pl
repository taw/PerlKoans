#!/usr/bin/perl
=pod
    Copyright (c) 2012, Salesforce.com, Inc.
    All rights reserved.

    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice, this list
    of conditions and the following disclaimer. Redistributions in binary form must
    reproduce the above copyright notice, this list of conditions and the following
    disclaimer in the documentation and/or other materials provided with the
    distribution.

    Neither the name of salesforce.com, inc. nor the names of its contributors may be
    used to endorse or promote products derived from this software without specific
    prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
    OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=cut

package Perl::Koans::Time;
use warnings;

use lib './lib';
use Perl::Koans;

################
# your code goes below this line

sub about_time {
    # about_time()

    my $before = time();
    sleep 1;
    my $after = time();

    is ($before < $after, 1, "time() returns the number of seconds since the epoch, 00:00 January 1, 1970 GMT");

    # more information in about_context.pl
    my @lt_array  = localtime(); # definition of elements: http://perldoc.perl.org/functions/localtime.html
    my $lt_scalar = localtime();

    is   ($lt_array[5], 2015 - 1900, "index 5 is the current year less 1900"); # TODO figure out how we can test the other elements in a dynamic, but not scary way
    like ($lt_scalar, qr/^\w\w\w \w\w\w \d\d \d\d:\d\d:\d\d \d\d\d\d$/, "in scalar context, localtime() gives us a human readable timestamp"); # TODO is this hint clear/vague enough? i want you to match anything you know will be in the timestamp: day of week, month, day of month

    # gmtime is just like localtime(), except it returns values localized to Greenwich
    my @gmt_array  = gmtime();
    my $gmt_scalar = gmtime();

    is ($#lt_array, $#gmt_array, "gmttime() has the same element count as localtime()");
    isnt (\@lt_array, \@gmt_array, "gmttime() has different contents than localtime()"); # TODO better hint

    ## TODO: add a gmttime($lt_scalar) and localtime($gmt_scalar) type test to show how it can be used as a function as well

    # This koan is broken, return value is not seconds
    # my $start = localtime();
    # sleep 1; # TODO yuck. should we just reuse $lt_scalar?
    # my $finish = localtime();

    # is ($finish - $start, 0, "localtime() is often used to keep track of how long an operation takes"); # TODO yeah, this is not a good hint. its true, but you should be using time() instead


    return (Perl::Koans::get_return_code());

}

sub about_time_hi_res {
    # about_time_hi_res()

    # Time::HiRes is in core as of 5.8, but if you don't have it, use CPAN to install

    use Time::HiRes; # in production code, all modules that are 'use'd should be grouped at the beginning of your script, only here for clarity

    my $start  = Time::HiRes::gettimeofday();
    my $finish = Time::HiRes::gettimeofday();

    is ($finish - $start > 0, 1, "Time::HiRes::gettimeofday() gives you microsecond precision");

    return (Perl::Koans::get_return_code());
}

# your code goes above this line
################

unless (caller(0)) {
    run(@ARGV) or print_illumination();
    exit();
}

sub run {
    # run() -- runs all functions in this module
    my $results = 0;

    $results += about_time();
    $results += about_time_hi_res();

    return ($results) ? bail($results) : $results;
}


1;
