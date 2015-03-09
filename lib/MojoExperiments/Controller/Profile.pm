package MojoExperiments::Controller::Profile;
use Mojo::Base 'Mojolicious::Controller';

use strict;

sub display_profile {
  my $self = shift;

  $self->render(template => 'profile');
}

sub save_profile {
  my $self = shift;

  my $session = $self->session;
  my $params  = $self->req->params;


  display_profile();
}

1;
