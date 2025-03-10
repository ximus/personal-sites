$ = jQuery

# Not very pertinient, wanted to have fun and test this out
# throttles a callback so that it gets invoked at most every
# @delay milliseconds
class Throttle
  constructor: (@delay) ->

  watch: (fn) =>
    timer = null
    last = null
    handler = =>
      now = Date.now()
      delay = @delay
      if timer
        clearTimeout timer
        @delay -= now - last
      timer = setTimeout((-> fn(); timer = null), delay)
      last  = now
    return handler


# Quick and dirty scroll tracking to highlight
# currently viewed section in nav
trackScrolling = (options) ->
  $window = $(window)
  onleave = options.leave
  onenter = options.enter
  offsets = []
  # assume sections are naturally sorted, offset(i) < offset(i+1)
  sections = $('article > section').each ->
    $section = $(this)
    offsets.push([$section.offset().top, $section])
  $last = null
  throttle = new Throttle(1000)
  onscoll = throttle.watch ->
    $current = null
    top = $window.scrollTop()
    for item, i in offsets
      [offset, $section] = item
      next_offset = offsets[i+1] and offsets[i+1][0]
      if offset <= top and top < next_offset
        $current = $section
        break
    if $current != $last
      onleave($last.get(0)) if $last
      onenter($current.get(0)) if $current
    $last = $current if $current
  $window.scroll onscoll

$.fn.star = ->

  $(this).each (i, item) ->
    item = $(item)
    # Match a 2-point decimal and an int ex: 2.3/5
    match = $(item).html().match(/(\d+(\.\d{1,2})?)\/(\d)/)

    if match and match.length > 2
      item = $(this)
      item.addClass 'starred'

      out = ""
      value  = parseInt(match[1])
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
  # page navigation through table of contents
  # TODO: fixed nav hides section headers, prevent this
  $("#toc li a").add('h2 > a.top').click (e) ->
  	e.preventDefault()
  	e.stopPropagation()
  	$('#toc').removeClass('showing')
  	offset = if $(this.hash).offset() then $(this.hash).offset().top else 0
  	$('html,body').animate({scrollTop:offset }, 500, 'swing')

  trackScrolling
    enter: (el) ->
      $("[href=##{el.id}]").parent().addClass('selected')
    leave: (el) ->
      $("[href=##{el.id}]").parent().removeClass('selected')

  $('#toc').bind 'touchend', (e) ->
    $(this).toggleClass('showing')

  # Add "return to top" links to section headers
  $('section > h2').each ->
    this.innerHTML += '<a href="#" class="top">back to top &uarr;</a>'
