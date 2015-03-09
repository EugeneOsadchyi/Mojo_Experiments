package MojoExperiments;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');
  $self->plugin('JSONConfig');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->any('/')->to('example#welcome')->name('home');
  $r->any('/home')->to('example#welcome')->name('home');

  $r->any('/login')->to('login#index')->name('login_index');

  my $logged_in = $r->under('/')->to('login#logged_in');
  $logged_in->get('/profile')->to('profile#profile');
  $logged_in->post('/profile')->to('profile#update_profile');

  $r->get('/logout')->to('login#logout');

  $r->get('/join')->to('join#display_join');
  $r->post('/join')->to('join#create_user');

  # $r->any('/profile')->to('profile#display_profile');
}

1;
