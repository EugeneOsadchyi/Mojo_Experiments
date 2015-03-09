package MojoExperiments::Model::Utils;

use Mojo::Base "MojoExperiments::Model::Base";

sub get_config_data {
  my $self = shift;

  return $self->app->config;
}

1;
