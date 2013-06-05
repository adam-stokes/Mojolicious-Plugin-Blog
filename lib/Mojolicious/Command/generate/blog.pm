package Mojolicious::Command::generate::blog;

# VERSION

use strictures 1;
use Mojo::Base "Mojolicious::Command";
use Mojo::Util;

has description => "Generate blog and database properties";
has usage => "usage: $0 generate blog";

sub run {
  my ($self, $class) = @_;
  say "Im running blog command";
}

1;
__END__

=head1 NAME

Mojolicious::Command::generate::blog - Blog generator for Mojolicious

=head1 DESCRIPTION

Helper to generate database connection and other config settings

=cut
