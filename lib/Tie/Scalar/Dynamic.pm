package Tie::Scalar::Dynamic;
use strict;
use warnings;
use 5.008008;

our $VERSION = '0.0.1';

use Tie::Scalar ();
BEGIN { our @ISA = qw(Tie::Scalar) }

sub TIESCALAR {
    my $class = shift;
    my $sub = shift;
    my $self = \$sub;
    bless $self, $class;
    return $self;
}

sub FETCH {
    my $self = shift;
    return scalar ${$self}->();
}


1;

__END__

=head1 NAME

Tie::Scalar::Dynamic - Ties a scalar to a dynamic function

=head1 SYNOPSIS

    use Tie::Scalar::Dynamic;

    tie my $time, 'Tie::Scalar::Dynamic', sub { time };


=head1 DESCRIPTION

Description

=head1 AUTHOR

Graham Knop <haarg@haarg.org>

=head1 LICENSE

Copyright (c) Graham Knop

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut


