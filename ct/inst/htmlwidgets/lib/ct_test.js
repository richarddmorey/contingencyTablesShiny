function ct_test_go(el){
  var j = ct_test_countme(el);
  var head = [];
  for(var i=0; i < j.ncol; i++){
   head.push( "c" + (i+1) );
  }
  var tab = $(el).children("table").tableToJSON({
    headings: head
  });

  var z = {
    m: tab
  };

  return JSON.stringify(z);
}

function ct_make_table(m, nrow, ncol)
{
  var table = $('<table><tbody>');
  for(var r = 0; r < nrow; r++)
  {
    var tr = $('<tr>');
    for (var c = 0; c < ncol; c++)
      $('<td>' + m[ r ][ c ] + '</td>').appendTo(tr);
    tr.appendTo(table);
  }
  return table;
}

function ct_test_countme(el)
{
  var ncell = $(el).find("td").length;
  var nrow = $(el).find("tr").length;
  var ncol = ncell / nrow;
  return {
    nrow: nrow,
    ncol: ncol
  };
}

function ct_test_checkbuttons(el){
  var j = ct_test_countme(el);
  if(j.nrow < 3){
    $(el).find(".del_row_button").hide(400);
  }else{
    $(el).find(".del_row_button").show(400);
  }
  if(j.ncol < 3){
    $(el).find(".del_col_button").hide(400);
  }else{
    $(el).find(".del_col_button").show(400);
  }
}

function ct_test_addrow(el)
{
  var j = ct_test_countme(el);
  var str = "<tr>\n";
  for( var i = 0 ; i < j.ncol ; i++ )
  {
    str += "<td>0</td>\n";
  }
  str += "</tr>\n";

  $(el).find("tr").last().after(str);
  $(el).find('td').on('input', function(evt){
    $(el).trigger("change");
  }).attr('contenteditable','true');

  ct_test_checkbuttons(el);
  $(el).trigger("change");

}


function ct_test_deleterow(el)
{
  var j = ct_test_countme(el);
  if( j.nrow < 3 ){
    alert("Cannot have fewer than two rows.");
    return;
  }

  $(el).find("tr").last().remove();
  ct_test_checkbuttons(el);
  $(el).trigger("change");
}

function ct_test_addcol(el)
{
  var j = ct_test_countme(el);

  $(el).find("tr").append("<td>0</td>");

  $(el).find('td').on('input', function(evt){
    $(el).trigger("change");
  }).attr('contenteditable','true');

  ct_test_checkbuttons(el);
  $(el).trigger("change");

}


function ct_test_deletecol(el)
{
  var j = ct_test_countme(el);
  if( j.ncol < 3 ){
    alert("Cannot have fewer than two rows.");
    return;
  }

  $(el).find("tr").each( function(){
    $( this ).children("td").last().remove();
  });

  ct_test_checkbuttons(el);
  $(el).trigger("change");
}



