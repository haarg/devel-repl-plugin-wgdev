use strict;
use warnings;

use Test::More;

my @modules = qw(
    Devel::REPL::Plugin::WGDev
);

plan tests => 2 * ( scalar @modules );

for my $library (@modules) {
    my $warnings = '';
    local $^W = 1;
    local $SIG{__WARN__} = sub {
        $warnings .= shift;
    };
    (my $module = $library) =~ s{::}{/}g;
    $module .= q{.pm};
    eval { require $module };
    chomp $warnings;
    is $@,        '', "$library compiles successfully";
    is $warnings, '', "$library compiles without warnings";
}

