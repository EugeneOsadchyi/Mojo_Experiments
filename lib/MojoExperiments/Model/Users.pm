package MojoExperiments::Model::Users;

use strict;
use warnings;

my $USERS = {
  john => '123',
};

sub new { bless {}, shift }

sub check {
  my ($self, $user, $pass) = @_;

  # Success
  return 1 if $USERS->{$user} && $USERS->{$user} eq $pass;

  # Fail
  return undef;
}
