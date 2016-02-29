#!/usr/bin/perl

use strict;
use MIME::Base64;

my ($to, $from) = @ARGV;
$from =~ s/autoreply.domain.ru/domain.ru/;
open MAIL, "| /usr/sbin/sendmail -t -oi";
print MAIL "To: $to\nFrom: noreply\@edomain.ru\nSubject: =?utf-8?B?0JLQsNGI0LUg0L/QuNGB0YzQvNC+INC90LUg0YPQtNCw0LvQvtGB0Ywg0LQ=?= =?utf-8?B?0L7RgdGC0LDQstC40YLRjC4=?=\n";
print MAIL 'MIME-Version: 1.0', "\n";
print MAIL 'Content-Type: text/html; charset="utf-8"', "\n";
print MAIL 'Content-Transfer-Encoding: base64', "\n\n";
# get text from file
open MSG, "/var/spool/filter/body.html";
;my $msg = join ( "", <MSG> );
print MAIL encode_base64($msg), "\n";
close MSG;

close MAIL;
