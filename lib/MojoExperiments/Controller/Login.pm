package MojoExperiments::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  $self->render(template => 'login/index');
}

1;
