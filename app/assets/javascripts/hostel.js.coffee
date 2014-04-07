$ ->
  root = $('#matrixHQ').attr('href')
  updateFlats = (hostel_id) ->
    $.getJSON root+'hostel/ajax/flats', {
      'hostel': hostel_id
    }, (flats) ->
      select = $('.ajax-flat')[0]
      if select
        select.options.length = 0
        select.options.add(
          new Option("#{flat.number}", flat.id)
        ) for flat in flats
        $(select).val(flats[0].id).change()

  updateRooms = (flat_id, type) ->
    $.getJSON root+'hostel/ajax/rooms', {
      'flat': flat_id
    }, (rooms) ->
      if type == 1
        select = $('.ajax-room')
        select.each ->
          this.options.length = 0
          this.options.add(
            new Option("#{room.seats}", room.id)
          ) for room in rooms
      if type == 2
        select = $('.ajax-room')[$('.ajax-room').length - 1]
        if select
          select.options.length = 0
          select.options.add(
            new Option("#{room.seats}", room.id)
          ) for room in rooms

  updateStudents = (flat_id, type) ->
    $.getJSON root+'hostel/ajax/students', {
      'flat': flat_id
    }, (students) ->
      if type == 1
        select = $('.ajax-student')
        select.each ->
          this.options.length = 0
          this.options.add(
            new Option("#{student.name}", student.id)
          ) for student in students
      if type == 2
        select = $('.ajax-student')[$('.ajax-student').length - 1]
        if select
         select.options.length = 0
         select.options.add(
            new Option("#{student.name}", student.id)
          ) for student in students

  $('.ajax-hostel').change ->
    updateFlats($(this).val())

  $('.ajax-flat').change ->
    updateRooms($(this).val(), 1)
    updateStudents($(this).val(), 1)

  $(document).on 'nested:fieldAdded:report_offenses', (event) ->
    offense_field = event.field.find('.offense')
    type = $(event.link).attr('data-type')
    offense_field.val($(event.link).attr('data-offense')).attr('data-type', type)
    if type == '2'
      offense_field.parents('.report_offenses_fields').find('.rooms_fields_btn').show()
    if type == '3'
      offense_field.parents('.report_offenses_fields').find('.students_fields_btn').show()

  $(document).on 'nested:fieldAdded:offense_rooms', ->
    updateRooms($('.ajax-flat').val(), 2)

  $(document).on 'nested:fieldAdded:offense_students', ->
    updateStudents($('.ajax-flat').val(), 2)

  $('.hostel_offenses').click ->
    $this = $(this)
    if $this.prop('checked')
      $link = $($('a[data-blueprint-id="report_offenses_fields_blueprint"]')[0])
      $link.attr('data-offense', $this.val()).attr('data-type', $this.data('type'))
      $link.click()
      $('.fields .offense[value="' +  $this.val() + '"][data-type="' + $this.data('type') + '"]').parents('.fields').appendTo($this.parent().next('.for_offense[data-type="' + $this.data('type') + '"]'))
    else
      offense = $this.val()
      $field = $('.fields .offense[value="' + offense + '"][data-type="' + $this.data('type') + '"]')
      $field.parents('.report_offenses_fields').children('.remove_nested_fields').click()

  $('#print_hostel_report_btn').click ->
    $('.hostel_reports_modal').modal('hide')

  $('.hostel_offense_group').click ->
    $this = $(this)
    $this.closest('.offense_check').find('.offense_group').toggle()
    if !$this.prop('checked')
      offense = $this.val()
      $('.hostel_offenses[value="' + offense + '"]').prop('checked', false)
      $field_1 = $('.fields .offense[value="' + offense + '"][data-type="' + 1 + '"]')
      $field_1.parents('.report_offenses_fields').children('.remove_nested_fields').click()
      $field_2 = $('.fields .offense[value="' + offense + '"][data-type="' + 2 + '"]')
      $field_2.parents('.report_offenses_fields').children('.remove_nested_fields').click()
