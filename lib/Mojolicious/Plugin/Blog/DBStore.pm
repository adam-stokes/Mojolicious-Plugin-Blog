package Mojolicious::Plugin::Blog::DBStore;

use strictures 1;
use DBIx::ResultSet;
use Mojo::Base -base;

# VERSION

has [qw(dsn dbuser dbpass dbconn dbrs)] => undef;

sub establish {
    my ($self, $app) = @_;

    # Connect to our trusty database
    $self->dbconn(
        DBIx::ResultSet->connect($self->dsn, $self->dbuser, $self->dbpass,));
    $self->dbrs($self->dbconn->resultset('posts'));
}

sub search {
    my $self = shift;
    my $app  = shift;
    my ($criteria, $opts) = @_;
    $self->dbrs->search($criteria, $opts)
      ->array_of_hash_rows(['id', 'title', 'body', 'created']);
}

1;

__END__
