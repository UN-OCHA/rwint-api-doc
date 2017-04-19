$(document).ready(function() {
  var counter = 1;

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

  // Copy works on input elements: need to clone the text to a hidden textarea.
  function copyToClipboard(element) {
    var oldPosX = window.scrollX;
    var oldPosY = window.scrollY;
    var cloneItem = element.cloneNode(true);
    var copyItem = document.createElement( "textarea" );
    var copyValue = cloneItem.value || cloneItem.textContent;
    copyItem.style.opacity = 0;
    copyItem.style.position = "absolute";
    copyItem.value = copyValue;
    document.body.appendChild(copyItem);

    copyItem.focus();
    copyItem.selectionStart = 0;
    copyItem.selectionEnd = copyValue.length;

    document.execCommand("copy");
    element.focus();
    // Restore the user's original position to avoid
    // 'jumping' when they click a copy button.
    window.scrollTo(
        oldPosX,
        oldPosY
    );
    element.selectionStart = 0;
    element.selectionEnd = copyValue.length;
    copyItem.remove();
  }

  function showResults(e) {
    e.preventDefault();
    var that = this,
        verb = 'get',
        parentElement = $( this ).parent().parent().parent(),
        postdata = '';
    if ($( parentElement ).find(' .post-parameters ').length) {
      var postdataElement = $( parentElement ).find(' .post-parameters ');
      postdata = $( postdataElement ).text();
      verb = 'post';
    }
    // Check that this is going to api.reliefweb.int
    var urlElement = $( parentElement ).find(' .url ');
    var url = $( urlElement ).text();
    if (!($( parentElement ).find(' .result ').length)) {
      $( parentElement ).append('<div class="result"></div>');
    }
    if (url.indexOf('https://api.reliefweb.int/v1') !== 0) {
        $( parentElement ).find(' .result ').html('<strong>Error:</strong> The call must be made to <code>https://api.reliefweb.int/v1</code>').show();
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
        var copyButtonText = "Copy GET URL";
        var copyElement = urlElement[0];
        if (postdata.length) {
          copyElement = postdataElement[0];
          copyButtonText = "Copy POST json";
        }
        $( parentElement ).find(' .result ').html('<button id="hideButton-' + counter + '" type="button">Hide results (Note the query can be edited)</button><button id="copyButton-' + counter + '" type="button">' + copyButtonText + '</button><pre><code>' + JSON.stringify(data, null, '\t') + '</code></pre>').show();
        document.getElementById("hideButton-" + counter).addEventListener('click', function(){$( this ).parent().remove()});
        document.getElementById("copyButton-" + counter).addEventListener('click', function(){copyToClipboard(copyElement)});
        counter++;
      }
    });
  }

  $(' .apiCall .url ').wrap('<div class="input-group"></div>').parent().append('<span class="input-group-btn"><button type="button" class="try btn btn-default" >Try it out</button>');
  $(' .apiCall .try ').click(showResults);

});
