package MojoExperiments::Controller::Profile;
use Mojo::Base 'Mojolicious::Controller';

use strict;

sub profile {
  my $self = shift;
  my $data = {};

  my $email = $self->signed_cookie('user');
  my $user_profile = $self->session('users')->{$email}->{profile};

  $data->{profile} = $user_profile;
  $data->{profile}->{email} = $email;

  $self->stash(template_args => $data);
  $self->render(template => 'login/profile');
}

sub update_profile {
  my $self = shift;

  my %form_inputs = @{$self->req->params->params};

  my $users = $self->session('users');
  my $email = delete $form_inputs{email};

  %{$users->{$email}->{profile}} = (%{$users->{$email}->{profile}}, %form_inputs);

  $self->session(users => $users);
  $self->flash(message => "Saved");
  $self->redirect_to('profile');
}

1;
