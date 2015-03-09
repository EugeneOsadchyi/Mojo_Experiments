package MojoExperiments::Controller::Join;
use Mojo::Base 'Mojolicious::Controller';
use MojoExperiments::Model::Users;

use Mojo::JSON qw(decode_json encode_json);

use Data::Dumper;

use constant DEBUG => 1;

sub display_join {
  my $self = shift;
  my $template_data = {};

  my $config = $self->app->config;

  $template_data->{render} = $config->{render};

  $self->stash(template_args => $template_data);
  $self->render(template => 'join');
}

sub create_user {
  my $self = shift;
  my $template_data = {};

  my %form_args = @{$self->req->params->params};

  my $users = $self->get_users_from_session || {};
  warn ("Get users from session: ", Dumper($users)) if (DEBUG);

  if (is_new_user($users, %form_args)) {
    $self->add_new_user($users, %form_args);
    $self->flash(message => 'Sucessfully registred new user');
    $self->redirect_to('/login');

    return;
  }

$template_data->{errors} = 1;

  $self->stash(template_args => $template_data);
    $self->redirect_to('/join');
}

sub get_users_from_session {
  my $self = shift;

  return $self->session->{users};
}

sub prepare_user_object {
  my %args = @_;

  my $email = delete $args{email};

  my $new_user = {
    $email => {
        profile => \%args
      }
    };

  return $new_user;
}

sub is_new_user {
  my ($users, %form_args) = @_;

  my $email = $form_args{email};

  return !defined $users->{$email};
}

sub add_new_user {
  my $self = shift;
  my ($users, %form_args) = @_;

  warn ("Adding new user: ", Dumper(\%form_args)) if (DEBUG);

  my $new_user  = prepare_user_object(%form_args);
  $users        = append_new_user($users, $new_user);

  $self->session(users => $users);
}

sub append_new_user {
  my ($users, $new_user) = @_;

  %{$users} = (%{$users}, %{$new_user});

  return $users;
}



1;
