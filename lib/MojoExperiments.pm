package MojoExperiments;
use Mojo::Base 'Mojolicious';
use MojoExperiments::Model;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  $self->plugin('JSONConfig');

  my $model = MojoExperiments::Model->new(app => $self);

  $self->helper(
    model => sub {
      my ($self, $model_name) = @_;
      return $model->get_model($model_name);
    }
  );

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/home')->to('example#welcome');

  $r->get('/login')->to('login#display_login');
  $r->post('/login')->to('login#process_login');

  $r->get('/join')->to('join#display_join');
  $r->post('/join')->to('join#create_user');

  $r->any('/profile')->to('profile#display_profile');
}

1;
