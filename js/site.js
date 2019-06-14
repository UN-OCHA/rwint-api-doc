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
    document.querySelector(' input:checked').checked = false;
    var tabs = document.querySelectorAll(' input ');
    var targetid = this.href.split('#')[1] + 'tab';
    for (var tab of tabs) {
      if (tab.id === targetid) {
        tab.checked = true;
        break;
      }
    }
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

  function toggle(button, collapse) {
    var target = document.getElementById(button.getAttribute('aria-controls'));
    var expanded = collapse || button.getAttribute('aria-expanded') === 'true';

    // Switch the expanded/collapsed states.
    button.setAttribute('aria-expanded', !expanded);
    target.setAttribute('data-hidden', expanded);
  }

  function collapseAll(exception) {
    var elements = document.querySelectorAll('[aria-expanded="true"]');
    for (var i = 0, l = elements.length; i < l; i++) {
      var element = elements[i];
      if (element !== exception) {
        toggle(elements[i], true);
      }
    }
  }

  function handleToggle(event) {
    var target = event.target;
    if (target) {
      if (target.nodeName === 'SPAN') {
        target = target.parentNode;
      }
      collapseAll(target);
      toggle(target);
    }
  }

  function handleOutsideClick(event) {
    var target = event.target;
    if (target) {
      if (target.nodeName === 'A') {
        collapseAll();
      }
      else if (target.hasAttribute) {
        var body = document.body;
        while (target && target.hasAttribute && !target.hasAttribute('aria-expanded') && !target.hasAttribute('data-hidden') && target !== body) {
          target = target.parentNode;
        }
        if (target && target.hasAttribute && !target.hasAttribute('aria-expanded') && !target.hasAttribute('data-hidden')) {
          collapseAll();
        }
      }
    }
  }

  function setToggler(id, textAccessibility, textDisplay) {
    var element = document.getElementById(id);

    // Skip if the element was not found.
    if (!element) {
      return;
    }

    // Add the aria attribute to control visibility to the form.
    element.setAttribute('data-hidden', true);

    // Button label.
    var label = document.createElement('span');
    label.appendChild(document.createTextNode(textDisplay));

    // Extended label for accessibility.
    var accessibleLabel = document.createElement('span');
    accessibleLabel.className = 'accessibility';
    accessibleLabel.appendChild(document.createTextNode(textAccessibility));

    // Create the button.
    var button = document.createElement('button');
    button.setAttribute('type', 'button');
    button.setAttribute('id', id + '-toggler');
    button.setAttribute('aria-expanded', false);
    button.setAttribute('aria-controls', id);
    button.setAttribute('value', textDisplay);
    button.appendChild(accessibleLabel);
    button.appendChild(label);

    // Add toggling function.
    button.addEventListener('click', handleToggle);

    // Add the button before the toggable element.
    element.parentNode.insertBefore(button, element);
  }

  if (document.documentElement.className === 'js') {
    // Collapse popups when clicking outside of the toggable target.
    document.addEventListener('click', handleOutsideClick);

    // Add the togglers.
    setToggler('ocha-services', 'Toggle', 'OCHA Services');
    setToggler('navigation-menu', 'Toggle navigation', 'menu');
  }
})();
