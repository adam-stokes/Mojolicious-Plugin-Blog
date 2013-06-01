package Mojolicious::Plugin::Blog;

use strictures 1;
use Mojo::Base 'Mojolicious::Plugin';
use File::Basename 'dirname';
use File::Spec::Functions 'catdir';

use Mojolicious::Plugin::Blog::Controller;

# VERSION

my %defaults = (

    # Basic options
    title   => 'Mojomomo Blog Plugin',
    slogan  => 'Im a really neat gorilla',
    author  => 'me-n-u',
    contact => 'momo\@example.com',
    tz      => 'America/New_York',

    # Social Integration options
    social => {
        github    => 'battlemidget',
        coderwall => 'battlemidget',
        twitter   => 'ajscg',
    },

    # Default routes
    indexPath       => '/blog/index',
    archivePath     => '/blog/archives',
    postPath        => '/blog/:id',
    adminPathPrefix => '/admin',

    # Router namespace
    namespace => 'Mojolicious::Plugin::Blog::Controller',

    # Set this to the under route for blog administration
    authCondition => undef,

    # TODO: Use json if you wish to provide custom templates.
    # renderType => undef,
);

sub register {
    my ($self, $app) = @_;
    my (%conf) = (%defaults, %{$_[2] || {}});

    my $base = catdir(dirname(__FILE__), 'BlogAssets');
    push @{$app->renderer->paths}, catdir($base, 'templates');
    push @{$app->static->paths},   catdir($base, 'public');

    push @{$app->renderer->classes}, __PACKAGE__;
    push @{$app->static->classes},   __PACKAGE__;

    $app->helper(blogconf => sub { \%conf });

    $app->routes->route($conf{indexPath})->via('GET')->to(
        namespace  => $conf{namespace},
        action     => 'blog_index',
        _blog_conf => \%conf,
    );

    $app->routes->route($conf{archivePath})->via('GET')->to(
        namespace  => $conf{namespace},
        action     => 'blog_archive',
        _blog_conf => \%conf,
    );

    $app->routes->route($conf{postPath})->via('GET')->to(
        namespace  => $conf{namespace},
        action     => 'blog_detail',
        _blog_conf => \%conf,
    );

    my $auth_r = $app->routes->under($conf{authCondition}->{authenticated});
    if ($auth_r) {
        $auth_r->route($conf{adminPathPrefix} . "/blog/new")->via('GET')->to(
            namespace  => $conf{namespace},
            action     => 'admin_blog_new',
            _blog_conf => \%conf,
        );
        $auth_r->route($conf{adminPathPrefix} . "/blog/edit/:id")->via('GET')->to(
            namespace  => $conf{namespace},
            action     => 'admin_blog_edit',
            _blog_conf => \%conf,
        );
        $auth_r->route($conf{adminPathPrefix} . "/blog/update/:id")->via('POST')->to(
            namespace  => $conf{namespace},
            action     => 'admin_blog_update',
            _blog_conf => \%conf,
        );
        $auth_r->route($conf{adminPathPrefix} . "/blog/delete/:id")->via('GET')->to(
            namespace  => $conf{namespace},
            action     => 'admin_blog_delete',
            _blog_conf => \%conf,
        );
    }
    return;
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Blog - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious

  # Set authentication condition
  my $conditions = {
    authenticated => sub {
        my $self = shift;
        unless ($self->session('authenticated')) {
            $self->flash(
                class   => 'alert alert-info',
                message => 'Please log in first!'
            );
            $self->redirect_to('/login');
            return;
        }
        return 1;
    },
  };

  $self->plugin('Blog' => {
      authCondition => $conditions
    }
  );

  # Mojolicious::Lite
  plugin 'Blog' => {
    authCondition => $conditions
  };

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
