package MojoExperiments::Controller::Join;
use Mojo::Base 'Mojolicious::Controller';

sub handler {
  my $self = shift;
  $self->render(template => 'join');
}

1;
