$(document).ready(function() {
  $('a.target').click(function() {

    $(' .nav-tabs li').removeClass('active');
    var targetHref = this.href;
    $(' .nav-tabs li').filter(function(index) { return $('a', this)[0].href === targetHref; }).addClass('active');
  });
  $(' .nav-sidebar a.target').click(function() {
    $('html, body').animate({
      scrollTop: $('#fields-tables').offset().top
    });
  });

  // This to make sure returns don't create divs in contenteditable.
  // https://stackoverflow.com/questions/6024594/avoid-createelement-function-if-its-inside-a-li-element-contenteditable
  $(' .apiCall .post-parameters ').keydown(function(e) {
    if (e.keyCode === 13) {
      if (window.getSelection) {
        var selection = window.getSelection(),
            range = selection.getRangeAt(0),
            br = document.createElement("br");
        range.deleteContents();
        range.insertNode(br);
        range.setStartAfter(br);
        range.setEndAfter(br);
        range.collapse(false);
        selection.removeAllRanges();
        selection.addRange(range);
        e.preventDefault();
      }
    }
  });

  function showResults(e) {
    e.preventDefault();
    var that = this,
        verb = 'get',
        parentElement = $( this ).parent().parent().parent(),
        postdata = '';
    if ($( parentElement ).find(' .post-parameters ').length) {
      postdata = $( parentElement ).find(' .post-parameters ').text();
      verb = 'post';
    }
    // Check that this is going to api.reliefweb.int
    var url = $( parentElement ).find(' .url ').text();
    if (!($( parentElement ).find(' .result ').length)) {
      $( parentElement ).append('<div class="result"></div>');
    }
    if (url.indexOf('http://api.reliefweb.int/v1') !== 0) {
        $( parentElement ).find(' .result ').html('<strong>Error:</strong> The call must be made to <code>http://api.reliefweb.int/v1</code>').show();
        return;
    }
    $.ajax({
      type: verb,
      url: url,
      datatype: 'json',
      data: postdata,
      error: function(data) {
        $( parentElement ).find(' .result ').html('<button type="button" onclick="$( this ).parent().remove()">Error - please edit the query and try again</button><pre><code>' + JSON.stringify(data, null, '\t') + '</code></pre>').show();
      },
      success: function(data) {
        $( parentElement ).find(' .result ').html('<button type="button" onclick="$( this ).parent().remove()">Hide results (Note the query can be edited)</button><pre><code>' + JSON.stringify(data, null, '\t') + '</code></pre>').show();
      }
    });
  }

  $(' .apiCall .url ').wrap('<div class="input-group"></div>').parent().append('<span class="input-group-btn"><button type="button" class="try btn btn-default" >Try it out</button>');
  $(' .apiCall .try ').click(showResults);

});
