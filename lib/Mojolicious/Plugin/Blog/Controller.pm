package Mojolicious::Plugin::Blog::Controller;

# VERSION

use strictures 1;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dump qw[pp];

sub blog_index {
  my $self = shift;

  $self->render('blog_index');
}

sub blog_archive {
  my $self = shift;
  $self->render('blog_archive');
}

sub blog_detail {
  my $self = shift;
  my $postid = shift;

  $self->stash(postid => $self->param('id'));
  $self->render('blog_detail');
}

1;
__END__
