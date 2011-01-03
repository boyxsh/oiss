/*
* jquery-ujs
*
* http://github.com/rails/jquery-ujs/blob/master/src/rails.js
*
* This rails.js file supports jQuery 1.4, 1.4.1 and 1.4.2 .
*
*/

jQuery(function ($) {
    var csrf_token = $('meta[name=csrf-token]').attr('content'),
        csrf_param = $('meta[name=csrf-param]').attr('content');

    $.fn.extend({
        /**
* Triggers a custom event on an element and returns the event result
* this is used to get around not being able to ensure callbacks are placed
* at the end of the chain.
*
* TODO: deprecate with jQuery 1.4.2 release, in favor of subscribing to our
* own events and placing ourselves at the end of the chain.
*/
        triggerAndReturn: function (name, data) {
            var event = new $.Event(name);
            this.trigger(event, data);

            return event.result !== false;
        },

        /**
* Handles execution of remote calls. Provides following callbacks:
*
* - ajax:before - is execute before the whole thing begings
* - ajax:loading - is executed before firing ajax call
* - ajax:success - is executed when status is success
* - ajax:complete - is execute when status is complete
* - ajax:failure - is execute in case of error
* - ajax:after - is execute every single time at the end of ajax call
*/
        callRemote: function () {
            var el = this,
                method = el.attr('method') || el.attr('data-method') || 'GET',
                url = el.attr('action') || el.attr('href'),
                dataType = el.attr('data-type') || 'script';

            if (url === undefined) {
              throw "No URL specified for remote call (action or href must be present).";
            } else {
                if (el.triggerAndReturn('ajax:before')) {
                    var data = el.is('form') ? el.serializeArray() : [];
                    $.ajax({
                        url: url,
                        data: data,
                        dataType: dataType,
                        type: method.toUpperCase(),
                        beforeSend: function (xhr) {
                            el.trigger('ajax:loading', xhr);
                        },
                        success: function (data, status, xhr) {
                            el.trigger('ajax:success', [data, status, xhr]);
                        },
                        complete: function (xhr) {
                            el.trigger('ajax:complete', xhr);
                        },
                        error: function (xhr, status, error) {
                            el.trigger('ajax:failure', [xhr, status, error]);
                        }
                    });
                }

                el.trigger('ajax:after');
            }
        }
    });

    /**
* confirmation handler
*/
    $('a[data-confirm], button[data-confirm], input[data-confirm]').live('click', function () {
        var el = $(this);
        if (el.triggerAndReturn('confirm')) {
            if (!confirm(el.attr('data-confirm'))) {
                return false;
            }
        }
    });
  


    /**
* remote handlers
*/
    $('form[data-remote]').live('submit', function (e) {
        $(this).callRemote();
        e.preventDefault();
    });

    $('a[data-remote],input[data-remote]').live('click', function (e) {
        $(this).callRemote();
        e.preventDefault();
    });

    $('a[data-method]:not([data-remote])').live('click', function (e){
        var link = $(this),
            href = link.attr('href'),
            method = link.attr('data-method'),
            form = $('<form method="post" action="'+href+'"></form>'),
            metadata_input = '<input name="_method" value="'+method+'" type="hidden" />';

        if (csrf_param != null && csrf_token != null) {
          metadata_input += '<input name="'+csrf_param+'" value="'+csrf_token+'" type="hidden" />';
        }

        form.hide()
            .append(metadata_input)
            .appendTo('body');

        e.preventDefault();
        form.submit();
    });

    /**
* disable-with handlers
*/
    var disable_with_input_selector = 'input[data-disable-with]',
        disable_with_form_remote_selector = 'form[data-remote]:has(' + disable_with_input_selector + ')',
        disable_with_form_not_remote_selector = 'form:not([data-remote]):has(' + disable_with_input_selector + ')';

    var disable_with_input_function = function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.data('enable-with', input.val())
                .attr('value', input.attr('data-disable-with'))
                .attr('disabled', 'disabled');
        });
    };

    $(disable_with_form_remote_selector).live('ajax:before', disable_with_input_function);
    $(disable_with_form_not_remote_selector).live('submit', disable_with_input_function);

    $(disable_with_form_remote_selector).live('ajax:complete', function () {
        $(this).find(disable_with_input_selector).each(function () {
            var input = $(this);
            input.removeAttr('disabled')
                 .val(input.data('enable-with'));
        });
    });

    var jqueryVersion = $().jquery;
    if (!( (jqueryVersion === '1.4') || (jqueryVersion === '1.4.1') || (jqueryVersion === '1.4.2') )){
      alert('This rails.js does not support the jQuery version you are using. Please read documentation.')
    }

});


// (function() {
//   // Technique from Juriy Zaytsev
//   // http://thinkweb2.com/projects/prototype/detecting-event-support-without-browser-sniffing/
//   function isEventSupported(eventName) {
//     var el = document.createElement('div');
//     eventName = 'on' + eventName;
//     var isSupported = (eventName in el);
//     if (!isSupported) {
//       el.setAttribute(eventName, 'return;');
//       isSupported = typeof el[eventName] == 'function';
//     }
//     el = null;
//     return isSupported;
//   }
// 
//   function isForm(element) {
//     return Object.isElement(element) && element.nodeName.toUpperCase() == 'FORM'
//   }
// 
//   function isInput(element) {
//     if (Object.isElement(element)) {
//       var name = element.nodeName.toUpperCase()
//       return name == 'INPUT' || name == 'SELECT' || name == 'TEXTAREA'
//     }
//     else return false
//   }
// 
//   var submitBubbles = isEventSupported('submit'),
//       changeBubbles = isEventSupported('change')
// 
//   if (!submitBubbles || !changeBubbles) {
//     // augment the Event.Handler class to observe custom events when needed
//     Event.Handler.prototype.initialize = Event.Handler.prototype.initialize.wrap(
//       function(init, element, eventName, selector, callback) {
//         init(element, eventName, selector, callback)
//         // is the handler being attached to an element that doesn't support this event?
//         if ( (!submitBubbles && this.eventName == 'submit' && !isForm(this.element)) ||
//              (!changeBubbles && this.eventName == 'change' && !isInput(this.element)) ) {
//           // "submit" => "emulated:submit"
//           this.eventName = 'emulated:' + this.eventName
//         }
//       }
//     )
//   }
// 
//   if (!submitBubbles) {
//     // discover forms on the page by observing focus events which always bubble
//     document.on('focusin', 'form', function(focusEvent, form) {
//       // special handler for the real "submit" event (one-time operation)
//       if (!form.retrieve('emulated:submit')) {
//         form.on('submit', function(submitEvent) {
//           var emulated = form.fire('emulated:submit', submitEvent, true)
//           // if custom event received preventDefault, cancel the real one too
//           if (emulated.returnValue === false) submitEvent.preventDefault()
//         })
//         form.store('emulated:submit', true)
//       }
//     })
//   }
// 
//   if (!changeBubbles) {
//     // discover form inputs on the page
//     document.on('focusin', 'input, select, texarea', function(focusEvent, input) {
//       // special handler for real "change" events
//       if (!input.retrieve('emulated:change')) {
//         input.on('change', function(changeEvent) {
//           input.fire('emulated:change', changeEvent, true)
//         })
//         input.store('emulated:change', true)
//       }
//     })
//   }
// 
//   function handleRemote(element) {
//     var method, url, params;
// 
//     var event = element.fire("ajax:before");
//     if (event.stopped) return false;
// 
//     if (element.tagName.toLowerCase() === 'form') {
//       method = element.readAttribute('method') || 'post';
//       url    = element.readAttribute('action');
//       params = element.serialize();
//     } else {
//       method = element.readAttribute('data-method') || 'get';
//       url    = element.readAttribute('href');
//       params = {};
//     }
// 
//     new Ajax.Request(url, {
//       method: method,
//       parameters: params,
//       evalScripts: true,
// 
//       onComplete:    function(request) { element.fire("ajax:complete", request); },
//       onSuccess:     function(request) { element.fire("ajax:success",  request); },
//       onFailure:     function(request) { element.fire("ajax:failure",  request); }
//     });
// 
//     element.fire("ajax:after");
//   }
// 
//   function handleMethod(element) {
//     var method = element.readAttribute('data-method'),
//         url = element.readAttribute('href'),
//         csrf_param = $$('meta[name=csrf-param]')[0],
//         csrf_token = $$('meta[name=csrf-token]')[0];
// 
//     var form = new Element('form', { method: "POST", action: url, style: "display: none;" });
//     element.parentNode.insert(form);
// 
//     if (method !== 'post') {
//       var field = new Element('input', { type: 'hidden', name: '_method', value: method });
//       form.insert(field);
//     }
// 
//     if (csrf_param) {
//       var param = csrf_param.readAttribute('content'),
//           token = csrf_token.readAttribute('content'),
//           field = new Element('input', { type: 'hidden', name: param, value: token });
//       form.insert(field);
//     }
// 
//     form.submit();
//   }
// 
// 
//   document.on("click", "*[data-confirm]", function(event, element) {
//     var message = element.readAttribute('data-confirm');
//     if (!confirm(message)) event.stop();
//   });
// 
//   document.on("click", "a[data-remote]", function(event, element) {
//     if (event.stopped) return;
//     handleRemote(element);
//     event.stop();
//   });
// 
//   document.on("click", "a[data-method]", function(event, element) {
//     if (event.stopped) return;
//     handleMethod(element);
//     event.stop();
//   });
// 
//   document.on("submit", function(event) {
//     var element = event.findElement(),
//         message = element.readAttribute('data-confirm');
//     if (message && !confirm(message)) {
//       event.stop();
//       return false;
//     }
// 
//     var inputs = element.select("input[type=submit][data-disable-with]");
//     inputs.each(function(input) {
//       input.disabled = true;
//       input.writeAttribute('data-original-value', input.value);
//       input.value = input.readAttribute('data-disable-with');
//     });
// 
//     var element = event.findElement("form[data-remote]");
//     if (element) {
//       handleRemote(element);
//       event.stop();
//     }
//   });
// 
//   document.on("ajax:after", "form", function(event, element) {
//     var inputs = element.select("input[type=submit][disabled=true][data-disable-with]");
//     inputs.each(function(input) {
//       input.value = input.readAttribute('data-original-value');
//       input.removeAttribute('data-original-value');
//       input.disabled = false;
//     });
//   });
// })();
