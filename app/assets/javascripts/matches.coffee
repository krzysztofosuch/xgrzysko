# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$ ->
  $(document).on('click', '.ttt-field',  ->
    that = $(this)
    $.ajax
      type: 'POST',
      url: window.location.href + '/set_stone'
      data:
        position:
          x: that.attr('x'),
          y: that.attr('y'),
          z: that.attr('z')
      success: ->
        document.location.reload()

  )
