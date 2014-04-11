use strict;
use warnings;
use utf8;
use Test::More;
use Devel::CheckBin;
use File::Temp;

subtest 'ok' => sub {
    plan skip_all => 'no ls' unless can_run('ls');

    my $out;
    {
        local *STDOUT;
        open *STDOUT, '>', \$out;
        check_bin('ls');
    }
    like $out, qr{Locating command: ls\.\.\. found at \S+};
    pass "OK";
};

subtest 'fail' => sub {
    my $fh = File::Temp->new();
    print {$fh} q{use Devel::CheckBin; check_bin( 'unknown_command_name_here' ); };
    $fh->close;

    my $err = `$^X -Ilib $fh 2>&1`;

    like ($err, qr/Please install 'unknown_command_name_here' seperately and try again./ms,
        "missing 'unknown_command_name_here'"
    );
};

done_testing;

