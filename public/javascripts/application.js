/**
 * For AJAX Pagination
 * source: http://wiki.github.com/mislav/will_paginate/ajax-pagination
 */

document.observe("dom:loaded", function() {
  // the element in which we will observe all clicks and capture
  // ones originating from pagination links
  var container = $(document.body)

  if (container) {
    var img = new Image
    img.src = '/images/ajax-loader.gif'

    function createSpinner() {
      return new Element('img', { src: img.src, 'class': 'spinner' })
    }

    container.observe('click', function(e) {
      var el = e.element()
      if (el.match('.pagination a')) {
        el.up('.pagination').insert(createSpinner())
        new Ajax.Request(el.href, { method: 'get' })
        e.stop()
      }
    })
  }
})

function activation_ready()
{
  listSel(document.getElementById('user_birth_date_1i'), 'aform');
  listSel(document.getElementById('user_birth_date_2i'), 'aform');
  listSel(document.getElementById('user_birth_date_3i'), 'aform');
  document.getElementById('user_email').readOnly = true;
  document.getElementById('user_voter_id').readOnly = true;
  document.getElementById('user_submit').disabled = false;
}

/*
 * From http://javascript.about.com/library/blorddrop2.htm
 */
function listSel(fld,id)
{
  var opt = fld.selectedIndex;
  var myform = document.getElementById(id);
  var optarray = myform.getElementsByTagName('select');
  var val = fld.options[opt].value;
  for (var i=optarray.length-1;i > -1; i--)
  {
    for (var j = optarray[i].length-1; j > -1; j--)
    {
      if (optarray[i] == fld)
      {
        if (fld.options[j].value != val)
        {
           fld.removeChild(optarray[i].options[j]);
        }
      }
      else if (optarray[i].options[j].value == val)
      {
        optarray[i].removeChild(optarray[i].options[j]);
      }
    }
  }
  for (var k=optarray.length-1;k > -1; k--)
  {
    if (optarray[k].length != 1) break;
  }
  if (k == -1)
  {
    var al = 'Your selections in order are:\n   ';
    for (var i=0;i < optarray.length; i++)
    {
      al += optarray[i].options[0].text + '\n   ';
    }
    //alert(al);
  }
}

