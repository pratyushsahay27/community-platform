package DDGC::Schema::ResultSet::User::Blog;

# ABSTRACT: Resultset class for blog posts

use Moo;
extends 'DDGC::Schema::ResultSet';
use DateTime::Format::RSS;
use List::MoreUtils qw( uniq );
use JSON::MaybeXS;
use DateTime;

sub create_via_form {
    my ( $self, $values ) = @_;
    return $self->create( $self->values_via_form($values) );
}

sub live {
    my ($self) = @_;
    $self->search(
        {
            live => 1,
        }
    );
}

sub company_blog {
    my ( $self ) = @_;
    return $self->search(
        {
            $self->me . 'company_blog' => 1,
            ( $self->current_user && $self->current_user->is('admin') )
            ? ()
            : ( $self->me . 'live' => 1 ),
        }
    );
}

sub util_json_string { JSON::MaybeXS->new->allow_nonref(1)->encode(shift) }

sub filter_by_topic {
    my ( $self, $topic ) = @_;
    $topic = util_json_string($topic);
    return $self->search(
        {
            $self->me . 'topics' => { like => sprintf( '%%%s%%', $topic ) }
        }
    );
}

sub TO_JSON {
    my ( $self ) = @_;
    [ map { $_->TO_JSON } $self->all ];
}

1;
