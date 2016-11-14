HTMLWidgets.widget({

  name: 'ct_test',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        console.log(JSON.stringify(x));

        var m = x.m;
        var ncol = x.ncol;
        var nrow = x.nrow;
        var table = ct_make_table(m, nrow, ncol);

        table.appendTo(el);

        $('<button/>', {
          text: "▼",
          "class": 'add_button add_row_button',
          click: function (evt) { ct_test_addrow(el) }
        }).appendTo(el);


        $('<button/>', {
          text: "△",
          "class": 'del_button del_row_button',
          click: function (evt) { ct_test_deleterow(el) }
        }).appendTo(el);

        $('<button/>', {
          text: "▶",
          "class": 'add_button add_col_button',
          click: function (evt) { ct_test_addcol(el) }
        }).appendTo(el);

        $('<button/>', {
          text: "◁",
          "class": 'del_button del_col_button',
          click: function (evt) { ct_test_deletecol(el) }
        }).appendTo(el);

        ct_test_checkbuttons(el);

        $(el).find('td').on('input', function(evt){

          $(el).trigger("change");

        }).attr('contenteditable','true');

        $(el).children("table").addClass('ct_test_table');

        $(el).on("change",
        function(evt){
            // evt.target is the button that was clicked
            var el = $(evt.target);

            // Raise an event to signal that the value changed
            //el.trigger("change");
            console.log(evt);
        });


      },

      resize: function(width, height) {
        // change
      }

    };
  }
});

var ct_test_goInBinding = new Shiny.InputBinding();

$.extend(ct_test_goInBinding, {
  find: function(scope) {
    return $(scope).find(".ct_test");
  },
  getValue: function(el) {
    return ct_test_go( el );
  },
  setValue: function(el, value) {
    return null;
  },
  subscribe: function(el, callback) {
    $(el).on("change.ct_test_goBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".ct_test_goBinding");
  }
});

Shiny.inputBindings.register(ct_test_goInBinding);

