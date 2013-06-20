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

1;

__END__
