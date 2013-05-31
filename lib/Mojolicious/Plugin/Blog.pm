package Mojolicious::Plugin::Blog;

use strictures 1;
use Mojo::Base 'Mojolicious::Plugin';
use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

use Mojolicious::Plugin::Blog::Controller;

# VERSION

my %defaults = (
    title       => 'Mojomomo Blog Plugin',
    slogan      => 'Im a really neat gorilla',
    author      => 'me-n-u',
    contact     => 'momo\@example.com',
    tz          => 'America/New_York',
    social      => {github => 'battlemidget', coderwall => 'battlemidget'},
    indexPath   => '/blog/index',
    archivePath => '/blog/archives',
    postPath    => '/blog/:id',
    namespace   => 'Mojolicious::Plugin::Blog::Controller',
);

sub register {
    my ($self, $app) = @_;
    my (%conf) = (%defaults, %{$_[2] || {}});

    my $base = catdir(dirname(__FILE__), 'Blog');
    push @{$app->renderer->paths}, catdir($base, 'templates');
    push @{$app->static->paths},   catdir($base, 'public');

    push @{$app->renderer->classes}, __PACKAGE__;
    push @{$app->static->classes},   __PACKAGE__;

    $app->routes->route($conf{indexPath})->via('GET')->to(
        namespace => $conf{namespace},
        action    => 'index',
    );

    $app->routes->route($conf{archivePath})->via('GET')->to(
        namespace => $conf{namespace},
        action    => 'archive',
    );

    $app->routes->route($conf{postPath})->via('GET')->to(
        namespace => $conf{namespace},
        action    => 'detail',
    );

    return;
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Blog - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Blog');

  # Mojolicious::Lite
  plugin 'Blog';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Blog> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Blog> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
