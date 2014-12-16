# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  boxes = $('[data-action="combo-box"]')
  boxes.each ->
    box = $(this)
    $('a', box).click ->
      $('input', box).val(this.text)
