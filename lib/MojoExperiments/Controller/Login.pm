package MojoExperiments::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

use Mojo::JSON qw(decode_json encode_json);

sub display_login {
  my $self = shift;

  $self->render(template => 'login');
}

sub process_login {
  my $self = shift;
warn(Data::Dumper::Dumper($self->req->params));
  my $user = $self->param('email') || '';
  my $pass = $self->param('password') || '';

  my $session = $self->session('users');

  if ($session->{$user} && $session->{$user}->{password} eq $pass) {
    $self->render(template => 'profile');
  } else {
    $self->render(text => 'User not found');
  }
}

1;
