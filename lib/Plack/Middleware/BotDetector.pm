package Plack::Middleware::BotDetector;
# ABSTRACT: Plack middleware to identify bots and spiders

use strict;
use warnings;

use parent 'Plack::Middleware';
use Plack::Util::Accessor 'bot_regex';

sub call
{
    my ($self, $env) = @_;
    my $user_agent   = $env->{HTTP_USER_AGENT};
    my $bot_regex    = $self->bot_regex;

    if ($user_agent)
    {
        $env->{'BotDetector.looks-like-bot'}++ if $user_agent =~ qr/$bot_regex/;
    }

    return $self->app->( $env );
}


1;

__END__

=pod

=head1 NAME

Plack::Middleware::BotDetector - Plack middleware to identify bots and spiders

=head1 VERSION

version 1.20120920.0752

=head1 SYNOPSIS

    enable 'Plack::Middleware::BotDetector',
        bot_regex => qr/Googlebot|Baiduspider|Yahoo! Slurp/;

=head1 DESCRIPTION

Any popular web site will get a tremendous amount of traffic from bots,
spiders, and other automated processes. Sometimes you want to do (or not do)
things when such a request comes in--for example, you may not want to log bot
traffic on your site.

This middleware applies an arbitrary, user-supplied regex to incoming requests
and sets a key in the PSGI environment if the user agent of the request
matches. Any other portion of your app which understands PSGI can examine the
environment for this key to take appropriate actions.

=head1 SPONSORSHIP

This module was extracted from L<http://trendshare.org/> under the sponsorship
of L<http://bigbluemarblellc.com/>.

=head1 AUTHOR

chromatic <chromatic@wgz.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by chromatic.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
