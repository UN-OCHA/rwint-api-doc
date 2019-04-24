(function() {

  'use strict';

  var tryText = "Try it out",
    counter = 1;

  // Show which Fields table tab is being displayed.
  var targets = document.getElementsByClassName('target');
  for (var i=0; i<targets.length; i++) {
    targets[i].addEventListener('click', handleActiveTab);
  }

  function handleActiveTab() {
    document.querySelector(' .nav-tabs li.active').classList.remove('active');
    var tabs = document.querySelectorAll(' .nav-tabs li ');
    var targetHref = this.href;
    for (var tab of tabs) {
      if (tab.children[0].href === targetHref) {
        tab.classList.add('active');
        break;
      }
    }
    // Move to the fields tables section.
    location.href = '#fields-table';
    window.scrollBy(0, -50);
  }

  // Submit queries on return for url fields.
  var urls = document.getElementsByClassName('url');
  for (var i=0; i<urls.length; i++) {
    urls[i].addEventListener('keydown', handleUrlReturns);
  }

  function handleUrlReturns(e) {
    if (e.keyCode === 13) {
      showResults(e);
    }
  }

  // Make sure returns don't create divs in contenteditable JSON.
  // https://stackoverflow.com/questions/6024594
  var posts = document.getElementsByClassName('post-parameters');
  for (var i=0; i<posts.length; i++) {
    posts[i].addEventListener('keydown', handleJsonReturns);
  }

  function handleJsonReturns(e) {
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
  }

  // Copy works on input elements: need to clone the text to a hidden textarea.
  function copyToClipboard(text) {
    var copyItem = document.createElement( "textarea" );
    copyItem.style.position = 'fixed';
    copyItem.value = text;
    document.body.appendChild(copyItem);
    copyItem.select();
    document.execCommand("copy");
    copyItem.remove();
  }

  function showResults(e) {
    e.preventDefault();
    var options = {method: "GET"};
    var apiCall = e.target.parentNode;
    // Check for post-parameters and results.
    for (var i=0; i<apiCall.children.length; i++) {
      if (apiCall.children[i].className === 'post-parameters') {
        var options = {
          method: "POST",
          body: apiCall.children[i].innerText
        };
      }
      // Get result div, if there is one.
      if (apiCall.children[i].className === 'result') {
        var result = apiCall.children[i];
      }
      // Change the try text.
      if (apiCall.children[i].className === 'try') {
        var tryButton = apiCall.children[i];
      }
    }
    // Create result div if necessary.
    if (!result) {
      result = document.createElement('div');
      result.setAttribute('class', 'result');
      apiCall.appendChild(result);
    }
    // Check that this is going to api.reliefweb.int
    var url = apiCall.children[0].innerText;
    if (url.indexOf('https://api.reliefweb.int/v1') !== 0) {
      result.innerHTML = "<strong>Error:</strong> The call must be made to <code>https://api.reliefweb.int/v1</code>";
      return;
    }

    // Query the API.
    fetch(url, options)
    .then(function(response) {
      return response.json();
    })
    .then(function(json) {
      var resultStatus = "success",
          reTry = "Try again (after editing the request)",
          copyType = (options.method === 'POST') ? "POST JSON" : "GET URL",
          copyText = (options.method === 'POST') ? options.body : url,
          html = '<button id="hideButton-' + counter + '">Hide results</button>';
      if (json.error) {
        resultStatus = "error";
        reTry = 'Error: "' + json.error.message + '" Adjust request and click to try again';
      }
      html += '<button id="copyButton-' + counter + '">Copy ' + copyType + '</button>';
      html += '<pre class="' + resultStatus + '">';
      html += '<code>' + JSON.stringify(json, null, '\t') + '</code>';
      html += '</pre>';

      // Add result.
      result.innerHTML = html;

      // Add functionality to buttons..
      document.getElementById("hideButton-" + counter).addEventListener('click', function() {
        this.parentElement.remove();
        tryButton.innerText = tryText;
      });
      document.getElementById("copyButton-" + counter).addEventListener('click', function() {copyToClipboard(copyText)});

      // Change the try text.
      tryButton.innerText = reTry;

      counter++;
    });
  }

  // Add 'try it out' buttons and handlers to all API calls.
  var calls = document.getElementsByClassName('apiCall');
  for (var i=0; i<calls.length; i++) {
    var tryIt = document.createElement('button');
    tryIt.setAttribute('class', 'try');
    tryIt.innerText = tryText;
    tryIt.addEventListener('click', showResults);
    calls[i].appendChild(tryIt);
  }

})();
