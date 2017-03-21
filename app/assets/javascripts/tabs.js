$(function() {
  var url = document.location.toString();
  if (url.match('#')) {
    var tabName = console.log(url.split('#')[1]);
    $('a.tab [href="#' + tabName + '"]').tab('show')
  }
});
