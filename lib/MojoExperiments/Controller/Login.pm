package MojoExperiments::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

sub index {
  my $self = shift;

  my $email = $self->param('email')     || '';
  my $pass  = $self->param('password')  || '';

  return $self->render unless $self->check_user($email, $pass);

  $self->signed_cookie(user => $email);
  $self->flash(message => "You are successfully logged in.");
  $self->redirect_to('profile');
}

sub logged_in {
  my $self = shift;
  return 1 if $self->signed_cookie('user');
  $self->redirect_to('login_index');
  return undef;
}

sub logout {
  my $self = shift;
  $self->signed_cookie('user' => '', { expires => 1 });
  $self->redirect_to('login_index');
}

####### Utils

sub check_user {
  my $self = shift;
  my ($email, $pass) = @_;

  my $session = $self->session('users');

  return 1 if ($session->{$email} && $session->{$email}->{profile}->{password} eq $pass);

  return 0;
}

1;
