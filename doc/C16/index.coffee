
p = console.log



Vector = class Vector

  constructor: (@x, @y)->
    #

  plus: (other)->
    new Vector  @x + other.x,  @y + other.y

  minus: (other)->
    new Vector  @x - other.x,  @y - other.y

  times: (factor)->
    new Vector  @x * factor,  @y * factor



when_down =
  cursor_position: null
  view: null



$(document).ready ->

  svg_element = $ '#schematic'
  view = (svg_element.get 0).viewBox.baseVal

  # Provides the position in pixels relative to the top-left corner of the SVG
  # element on screen
  cursor_position = (event)->
    e = event.originalEvent
    cursor_on_page = new Vector  e.pageX,  e.pageY
    so = svg_element.offset()
    svg_element_on_page = new Vector  so.left,  so.top
    cursor_on_page.minus  svg_element_on_page

  # To convert screen ordinates to and from space ordinates
  scale =
    factor: null  # Number of space ordinate units spanned by one pixel on screen
    update: ->
      # `svg_element.width()` is the number of pixels across the display
      # occupied by the SVG element within the document whereas `view.width` is
      # in SVG units
      scale.factor = view.width / svg_element.width()

  report_view_box = ->
    console.log "viewBox=\"#{view.x} #{view.y} #{view.width} #{view.height}\""

  scale.update()

  when_dragged = (event)->
    cp = cursor_position  event
    movement = cp.minus  when_down.cursor_position
    nv = when_down.view.minus  movement.times  scale.factor
    view.x = Math.round  nv.x
    view.y = Math.round  nv.y

    # Doing the following in all event handlers was required to prevent Firefox
    # dragging the SVG around like an image
    event.originalEvent.preventDefault()
    false

  svg_element.on 'mousedown', (event)->

    when_down.cursor_position = cursor_position  event
    when_down.view = new Vector  view.x,  view.y
    svg_element.on 'mousemove', when_dragged

    event.originalEvent.preventDefault()
    false

  ($ window).on 'mouseup', (event)->

    when_down.cursor_position = null
    when_down.view = null
    svg_element.off 'mousemove', when_dragged

    report_view_box()

    event.originalEvent.preventDefault()
    false

  svg_element.on 'wheel', (event)->

    movement = event.originalEvent.deltaY  # -3 or +3.  Hold Shift to prevent scrolling

    factor = if 0 < movement then 1.1 else (1 / 1.1)

    # The location beneath the cursor should not move throughout the zoom

    # view.x is the X ordinate of the top-left corner of the view of the SVG element in SVG ordinates
    # view.width is the width of the view of the SVG element in SVG ordinates
    # cursor_position is the position in pixels relative to the top-left corner of the element on screen
    # svg_element.width() is the width of the SVG element on screen in pixels

    # maybe talk about "screen ordinates" (in pixels) and "space ordinates" (in SVG units)

    # The position on the schematic beneath the cursor should not move through the zoom
    # Work out the position of the corners relative to the cursor and scale
    # those.  Only the topleft (and dimensions) needs scaling though

    # Determine the location beneath the cursor in space ordinates
    cursor_on_screen = cursor_position  event   # relative to topleft of SVG element on screen
    view_topleft_in_space = new Vector  view.x,  view.y
    cursor_in_space = view_topleft_in_space.plus  cursor_on_screen.times  scale.factor

    # Scale the vector from the cursor (in space) to the view topleft (in space)
    from_cursor_to_topleft = view_topleft_in_space.minus  cursor_in_space
    nv = cursor_in_space.plus  from_cursor_to_topleft.times  factor
    view.x = nv.x
    view.y = nv.y

    # Is this the same as translating the center to the cursor, scaling then
    # translating back?

    view.width *= factor
    view.height *= factor
    scale.update()

    report_view_box()

    # The page should not scroll when the pointer is over the SVG element.
    # This handler should not be attached to `window` but only the SVGElement
    # otherwise scrolling is prevented for the rest of the page
    event.originalEvent.preventDefault()
    false

