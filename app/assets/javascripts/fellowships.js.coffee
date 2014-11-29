# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.initRanker = (options) ->
  choices = $.makeArray($(options.choices))
  fellowships = $.makeArray($(options.fellowships))
  submitted = options.submitted

  fsMap = fellowships.reduce ((map, f) ->
    map[f.id] = f
    map
  ), {}

  alerts = $(options.alerts)
  dropdown = $(options.dropdown)
  form = $(options.form)

  showAlert = (cls, msg) ->
    alert = "<div class=\"fade in alert alert-#{cls}\" role=\"alert\">
              #{msg}
              <button type=\"button\" class=\"close\" data-dismiss=\"alert\">
                <span aria-hidden=\"true\">&times;</span>
                <span class=\"sr-only\">Close</span>
              </button>
            </div>"
    alerts.append(alert)

  menuItemIsActive = (id) ->
    id not in choices.map (c) -> c.id

  addChoice = (id) ->
    if choices.length >= options.max_selected
      showAlert('danger', 'You have already selected the maximum number of choices. Remove some before you add new ones.')
    else
      choices.push({ id: id, statement: "", budget: ""})
      refresh()

  updateChoice = (id, field, val) ->
    i = choices.map((c) -> c.id).indexOf(id)
    choices[i][field] = val
    console.log choices[i]
    console.log choices

  removeChoice = (id) ->
    choices = choices.filter (f) -> f.id != id
    refresh()

  moveChoiceUp = (id) ->
    i = choices.map((c) -> c.id).indexOf(id)
    return if i == 0
    tmp = choices[i]
    choices[i] = choices[i-1]
    choices[i-1] = tmp
    refresh()

  moveChoiceDown = (id) ->
    i = choices.map((c) -> c.id).indexOf(id)
    return if i + 1 == choices.length
    tmp = choices[i]
    choices[i] = choices[i+1]
    choices[i+1] = tmp
    refresh()

  refresh = ->
    updateMenuItems()
    updateChoices()
    if submitted
      $('.main-content-body .btn').addClass 'disabled'
      dropdown.html("<p>You have submitted your preferences.</p>
        <a href=\"#{options.return_url}\" class=\"btn btn-primary\">Back</a>")

  getFullCity = (f) ->
    if f.state?.length then "#{f.city}, #{f.state}" else f.city

  updateMenuItems = ->
    for submenu in $('.dropdown-menu', dropdown)
      submenu = $(submenu)
      category = submenu.data('category')
      items = fellowships.filter (f) -> f.category == category
      html = items.reduce ((html, f) ->
        cls = if menuItemIsActive(f.id) then '' else ' disabled'
        html + "
        <li class=\"#{cls}\">
          <a class=\"fellowship-choice\" tabindex=\"-1\" href=\"#\" data-fellowship-id=\"#{f.id}\">
            #{f.name}
            <span class=\"fellowship-city\">#{getFullCity(f)}</span>
          </a>
        </li>"
      ), ''

      # Populate submenu
      submenu.html(html)

      # Add click handlers to all dropdown menu items
      $('.fellowship-choice', submenu).click (e) ->
        e.preventDefault()
        id = $(this).data('fellowship-id')
        return unless menuItemIsActive(id)
        addChoice(id)


  updateChoices = ->
    html = if choices.length > 0
      choices.reduce ((html, c, i) ->
        cls = if i >= options.max_applied then 'hidden' else ''
        f = fsMap[c.id]
        html + "
        <div class=\"panel panel-default\">
          <div class=\"panel-heading clearfix\">
            <div class=\"pull-right btn-group\" data-id=\"#{f.id}\">
              <button data-action=\"up\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-chevron-up\"></i></button>
              <button data-action=\"down\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-chevron-down\"></i></button>
              <button data-action=\"remove\" class=\"btn btn-sm btn-default\"><i class=\"fa fa-times\"></i></button>
            </div>


            <div class=\"rank-badge pull-left\"><span class=\"badge\">#{i + 1}</span></div>

            <h2 class=\"panel-title\">#{f.name}
              <span class=\"fellowship-city\">#{getFullCity(f)}</span>
            </h2>  
          </div>
          <div class=\"panel-body\">
            <form data-id=\"#{f.id}\" class=\"#{cls}\">
              
              <div class=\"form-group\">
                <label class=\"string required control-label\">reason for interest</label>
                <textarea data-modify=\"statement\" class=\"text required form-control\" rows=\"1\" placeholder=\"Describe why you are interested in this particular fellowship.\">#{c.statement}</textarea>
              </div>

              <div class=\"form-group\">
                <label class=\"string required control-label\">budget</label>
                <textarea data-modify=\"budget\" class=\"text required form-control\" rows=\"1\" placeholder=\"Give an overview of the budget estimates.\">#{c.budget}</textarea>
              </div>

            </form>
          </div>
        </div>
        "
      ), ''
    else
      '<p>You have not selected any fellowships.</p>'
    $('.selected-choices', form).html(html)

    $('[data-action=remove]', form).click ->
      id = $(this).parent().data('id')
      removeChoice(id)

    $('[data-action=up]', form).click ->
      id = $(this).parent().data('id')
      moveChoiceUp(id)

    $('[data-action=down]', form).click ->
      id = $(this).parent().data('id')
      moveChoiceDown(id)

    $('[data-modify]', form).change ->
      id = $(this).closest('form').data('id')
      field = $(this).data('modify')
      val = $(this).val()
      updateChoice(id, field, val)

    $('textarea', form).focus ->
      $(this).animate({rows: 10}, 200)

    $('textarea', form).blur ->
      $(this).animate({rows: 1}, 200)

  saveChoices = (elem, success) ->
    elem.addClass 'disabled'
    $('i', elem).addClass('fa-spinner')
    jqxhr = $.post(options.save_url, {type: elem.data('action'), json: JSON.stringify(choices)})
    jqxhr.fail ->
      showAlert('danger', jqxhr.responseText)
    jqxhr.done ->
      success?()
    jqxhr.always ->
      elem.removeClass 'disabled'
      $('i', elem).removeClass('fa-spinner')


  $('[data-action=save]').click ->
    saveChoices $(this)

  $('[data-action=submit]').click ->
    if confirm("Are you sure you want to submit your preferences? You will not be able to edit them anymore after submission!")
      saveChoices $(this), ->
        window.location = options.return_url

  refresh()
