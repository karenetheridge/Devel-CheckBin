use strict;
use warnings;
use utf8;
use Test::More;
use Devel::CheckBin;
use File::Temp;

plan skip_all => 'these tests are for win32' unless $^O eq 'MSWin32';

my $out;
{
    local *STDOUT;
    open *STDOUT, '>', \$out;
    check_bin('perl');
}
like $out, qr{Locating command: cmd.\.\. found at cmd.exe}i;
pass "found command with extension: $out";

done_testing;
