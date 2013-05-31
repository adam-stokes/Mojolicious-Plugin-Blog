package Mojolicious::Plugin::Blog::Controller;

use strictures 1;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;
}

sub archive {
  my $self = shift;
}

sub detail {
  my $self = shift;
  my $postid = shift;
}

1;
__END__
