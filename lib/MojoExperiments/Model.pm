package MojoExperiments::Model;

use Mojo::Loader;
use Mojo::Base -base;

use Carp qw/ croak /;

has modules => sub { {} };

sub new {
  my ($class, %args) = @_;
  my $self = $class-> SUPER::new(%args);

  my $model_packages = Mojo::Loader->search('MojoExperiments::Model');
  for my $pm (grep { $_ ne 'MojoExperiments::Model::Base' } @{$model_packages}) {
    my $e = Mojo::Loader->load($pm);
    croak "Loading '$pm' failed: $e" if ref $e;
    my ($basename) = $pm =~ /MojoExperiments::Model::(.*)/;
    $self->modules->{$basename} = $pm->new(%args);
  }
}

sub get_model {
  my ($self, $model) = @_;
  return $self->modules->{$model} || croak "Unknown model '$model'";
}

1;
