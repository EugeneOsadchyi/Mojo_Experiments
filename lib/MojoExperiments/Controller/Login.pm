package MojoExperiments::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub handler {
  my $self = shift;
  $self->render(template => 'login');
}

1;
