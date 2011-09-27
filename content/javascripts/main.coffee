#= require columns-polyfill
# require libs/annotate/annotate

$ = jQuery

$.fn.star = ->
  
  $(this).each (i, item) ->
    item = $(item)
    # Match a 2-point decimal and an int ex: 2.3/5
    match = $(item).html().match(/(\d+(\.\d{1,2})?)\/(\d)/)

    if match and match.length > 2
      item = $(this)
      item.addClass 'starred'
    
      out = ""                                                                                
      value = parseInt(match[1])
      out_of = parseInt(match[3])
    
      for i in [1..value]
        out = out + "<span class=\"star filled\"/>\n"
      
      for i in [value...out_of]
        out = out + "<span class=\"star empty\"/>\n"
      
      item.html out         
    # End if match 
  # End Loop
# End star

$(document).ready ->
  $('#skills .starme span').star()
  $("#nav li a").add('h2 > a.top').click (e) ->	
  	e.preventDefault()
  	e.stopPropagation()
  	$('#nav').removeClass('showing')   
  	offset = if $(this.hash).offset() then $(this.hash).offset().top else 0
  	$('html,body').animate({scrollTop:offset }, 500, 'swing')
  	
  $('#nav').bind 'touchend', (e) ->
    $(this).toggleClass('showing')
    
  # Other skills spread accross columns
  $('#skills .last ul').columnizeList({
    columnCount: 4
  })
  
  