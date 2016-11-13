function ct_test_go(el){
  var ncell = $(el).find("td").length;
  var nrow = $(el).find("tr").length;
  var ncol = ncell / nrow;
  var head = [];
  for(var i=0; i < ncol; i++){
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

function ct_make_table(m, nrow, ncol){
  
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
