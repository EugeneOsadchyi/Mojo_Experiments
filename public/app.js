$('#form-signin').submit(function(event) {
  event.preventDefault();

  var $form = $(this),
      email = $form.find( "input[name='email']" ).val(),
      pass  = $form.find( "input[name='password']" ).val(),
      url   = $form.attr( "action" );

  $.post( url, {
      email:    email,
      password: pass
  })
    .done(function(data) {
      if(data.sussess) {
        
      } else {
        var $result = $('#result');
        $result.html(data.status).show();
      }
    })
});
