package Devel::REPL::Plugin::WGDev;
use strict;
use warnings;
use 5.008008;

our $VERSION = '0.0.1';

use Devel::REPL::Plugin;
use namespace::clean -except => [ 'meta' ];

use Tie::Simple;

has 'wgd' => (
    is => 'ro',
    isa => 'WGDev',
    lazy => 1,
    default => sub {
        require WGDev;
        require WGDev::Command;
        my $wgd = WGDev->new;
        WGDev::Command->guess_webgui_paths(wgd => $wgd);
        return $wgd;
    },
);

sub BEFORE_PLUGIN {
    my $self = shift;
    $self->load_plugin('Turtles');
}

sub AFTER_PLUGIN {
    my $self = shift;

    $self->lexical_environment->set_context(
        '_' => {
            '$wgd'     => undef,
            '$session' => undef,
        },
    );

    my $context = $self->lexical_environment->get_context('_');
    tie $context->{'$wgd'},     'Tie::Simple', undef,
        FETCH => sub { $self->wgd },
        STORE => sub { $self->wgd },
    ;
    tie $context->{'$session'}, 'Tie::Simple', undef,
        FETCH => sub { $self->wgd->session },
        STORE => sub {
            $self->wgd->close_session;
            $self->wgd->close_config;
        },
    ;
}

sub command_wgd {
    my $self = shift;
    my $code = shift;
    my $text = shift;

    require Text::ParseWords;
    my @args = Text::ParseWords::shellwords($text);

    # TODO: have a better API for this to keep the wgd object around
    require WGDev::Command;
    WGDev::Command->run();
    return '';
}

1;

__END__

=head1 NAME

Devel::REPL::Plugin::WGDev - WGDev commands for Devel::REPL

=head1 SYNOPSIS

    $_REPL->load_plugin('WGDev');

=head1 DESCRIPTION

Adds WGDev commands and easy access to WGDev and WebGUI::Session objects to Devel::REPL

=head1 AUTHOR

Graham Knop <haarg@haarg.org>

=head1 LICENSE

Copyright (c) 2009, Graham Knop

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl 5.10.0. For more details, see the
full text of the licenses in the directory LICENSES.

=cut

