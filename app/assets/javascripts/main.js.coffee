# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  autoSelect = $('input[data-behavior="auto-select"]')
  autoSelect.mouseup (e) ->
    e.preventDefault()
  autoSelect.focus ->
    $(this).select()

  autoExpand = $('textarea[data-behavior="auto-expand"]')
  autoExpand.focus ->
    $(this).data('original-rows', $(this).attr('rows'))
    $(this).animate({rows: 10}, 200)
  autoExpand.blur ->
    $(this).animate({rows: $(this).data('original-rows')}, 200)