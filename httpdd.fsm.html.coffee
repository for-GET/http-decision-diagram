jsonFsmUrl = window.location.search.substr 1
jsonFsmUrl = if jsonFsmUrl.length then jsonFsmUrl else 'httpdd.fsm.json'
$.ajaxSetup cache: false
window.onhashchange = () ->
  window.location.reload()

stmts = []
vars = {}
declarations =
  state: {}
  status_code: {}
  decision: {}
  block: {}
  block_entry: {}
transitions = {}

gridMultiplier = parseInt(window.location.hash.substr(1), 10) or 20 # in pixels
gridCellWidth = 10 # * gridMultiplier for pixels
gridCellHeight = 4 # * gridMultiplier for pixels
gridCellsH = 1
gridCellsV = 1
cells = []
fontSize = gridMultiplier * .5
# http://www.w3schools.com/cssref/css_websafe_fonts.asp
fontFamily = '"Trebuchet MS", Helvetica, sans-serif'
fontFamilyMonospace = '"Lucida Console", Monaco, monospace'
colorGrid = '#EEEEEE'
colorCoord = '#AAAAAA'
colorStatusCodeText = '#000000'
colorStatusCodeBlock = '#EEEEEE'
colorDecisionText = '#000000'
colorDecisionBlock = '#EEEEEE'
colorTrue = '#00FF00'
colorFalse = '#FF0000'
colorAnything = '#0000FF'

openDataUrl = (dataUrl) ->
  win = window.open()
  unless win
    alert 'Please allow pop-up windows.'
    return
  win.document.write '<iframe src="' + dataUrl  + '" frameborder="0" style="border:0; top:0px; left:0px; bottom:0px; right:0px; width:100%; height:100%;" allowfullscreen></iframe>'

render = () ->
  # TITLE VERSION URL
  cells.push new joint.shapes.basic.Text {
    position:
      x: fontSize * 4
      y: fontSize * 4
    size:
      width: 'auto'
      height: 'auto'
    attrs:
      text:
        text: vars.Title + ' ' + vars.Version + ' (https://github.com/for-GET/http-decision-diagram)'
        'font-size': fontSize
        'font-family': fontFamilyMonospace
        'font-weight': 'bold'
        fill: '#000000'
   }

  paperWidth = gridMultiplier * gridCellWidth * gridCellsH
  paperHeight = gridMultiplier * gridCellHeight * gridCellsV

  graph = new joint.dia.Graph()
  window.paper = paper = new joint.dia.Paper {
    el: $ '#paper'
    width: paperWidth
    height: paperHeight
    gridSize: gridMultiplier
    model: graph
    async: true
  }

  # GRID

  V(paper.svg).defs().append V """
  <pattern id="smallGrid" width="#{gridMultiplier}" height="#{gridMultiplier}" patternUnits="userSpaceOnUse">
    <path d="M #{gridMultiplier} 0 L 0 0 0 #{gridMultiplier}" fill="none" stroke="#{colorGrid}" stroke-width="0.5"/>
  </pattern>
  <pattern id="grid" width="#{gridMultiplier * gridCellWidth}" height="#{gridMultiplier * gridCellHeight}" patternUnits="userSpaceOnUse">
    <rect width="#{gridMultiplier * gridCellWidth}" height="#{gridMultiplier * gridCellHeight}" fill="url(#smallGrid)"/>
    <path d="M #{gridMultiplier * gridCellWidth} 0 L 0 0 0 #{gridMultiplier * gridCellHeight}" fill="none" stroke="#{colorGrid}" stroke-width="1"/>
  </pattern>
  """
  V(paper.svg).prepend V """
  <rect width="100%" height="100%" fill="url(#grid)" />
  """

  # COLS,LINS

  do () ->
    for i in [1..gridCellsH - 1]
      cells.push new joint.shapes.basic.Text {
        position:
          x: paperWidth * i / gridCellsH
          y: 0
        size:
          width: 'auto'
          height: 'auto'
        attrs:
          text:
            text: String.fromCharCode("A".charCodeAt(0) + i - 1)
            transform: "translate(#{-fontSize / 2}, #{fontSize})"
            'font-size': fontSize
            'font-family': fontFamilyMonospace
            'font-weight': 'bold'
            fill: colorCoord
      }
      cells.push new joint.shapes.basic.Text {
        position:
          x: paperWidth * i / gridCellsH
          y: paperHeight
        size:
          width: 'auto'
          height: 'auto'
        attrs:
          text:
            text: String.fromCharCode("A".charCodeAt(0) + i - 1)
            transform: "translate(#{-fontSize / 2}, #{-fontSize})"
            'font-size': fontSize
            'font-family': fontFamilyMonospace
            'font-weight': 'bold'
            fill: colorCoord
      }

    for i in [1..gridCellsV - 1]
      cells.push new joint.shapes.basic.Text {
        position:
          x: 0
          y: paperHeight * i / gridCellsV
        size:
          width: 'auto'
          height: 'auto'
        attrs:
          text:
            text: if i > 9 then '' + i else '0' + i
            transform: "translate(#{fontSize}, #{-fontSize / 2})"
            'font-size': fontSize
            'font-family': fontFamilyMonospace
            'font-weight': 'bold'
            fill: colorCoord
      }
      cells.push new joint.shapes.basic.Text {
        position:
          x: paperWidth
          y: paperHeight * i / gridCellsV
        size:
          width: 'auto'
          height: 'auto'
        attrs:
          text:
            text: if i > 9 then '' + i else '0' + i
            transform: "translate(#{-fontSize}, #{-fontSize / 2})"
            'font-size': fontSize
            'font-family': fontFamilyMonospace
            'font-weight': 'bold'
            fill: colorCoord
      }

  # CELLS

  graph.addCells cells


# GRAPH OVERRIDE

joint.shapes.httpdd = {}

do () ->
  diameter = gridMultiplier * 2

  joint.shapes.fsa.StartState = joint.dia.Element.extend {
    markup: '<g class="rotatable"><g class="scalable"><circle/></g></g>'
    defaults: joint.util.deepSupplement {
      type: 'fsa.StartState'
      size:
        width: diameter
        height: diameter
      attrs:
        circle:
          r: diameter / 2
          fill: 'black'
    }, joint.dia.Element::defaults
  }

do () ->
  diameter = gridMultiplier * 2

  joint.shapes.fsa.EndState = joint.dia.Element.extend {
    markup: '<g class="rotatable"><g class="scalable"><circle class="outer"/><circle class="inner"/></g></g>'
    defaults: joint.util.deepSupplement {
      type: 'fsa.EndState'
      size:
        width: diameter
        height: diameter
      attrs:
        '.outer':
          r: diameter
          fill: 'white'
          stroke: 'black'
        '.inner':
          r: diameter / 2
          fill: 'black'
    }, joint.dia.Element::defaults
  }

do () ->
  width = gridMultiplier * 2
  height = gridMultiplier * 2

  joint.shapes.httpdd.Decision = joint.dia.Element.extend {
    markup: '<g class="rotatable"><g class="scalable"><path/></g><text class="decision"/><text class="coord"/></g>'
    defaults: joint.util.deepSupplement {
      type: 'httpdd.Decision',
      size:
        width: width
        height: height
      attrs:
        '.':
          fill: '#FFFFFF'
          stroke: 'none'
        path:
          d: "M #{height / 2} 0 L #{height} #{width / 2} #{height / 2} #{width} 0 #{width / 2} z"
          transform: 'translate(' + (-height / 2) + ', ' + (-width / 2) + ')'
          'stroke-width': 0
          fill: colorDecisionBlock
        '.decision':
          'font-size': fontSize
          'font-weight': 'bold'
          text: ''
          'text-anchor': 'middle'
          ref: 'path'
          'y-alignment': 'middle'
          fill: colorDecisionText
          'font-family': fontFamily
          'ref-x': .5
          'ref-y': .2
          transform: "translate(0, 0)" # to please jointjs, and don't throw errors
        '.coord':
          'font-size': fontSize
          'font-weight': 'bold'
          text: ''
          'text-anchor': 'middle'
          'ref-x': .5
          'ref-y': .5
          ref: 'path'
          'y-alignment': 'middle'
          fill: colorCoord
          'font-family': fontFamily
          transform: "translate(0, 0)" # to please jointjs, and don't throw errors
    }, joint.dia.Element::defaults
  }

# joint.shapes.httpdd.BlockEntry = joint.shapes.basic.Rhombus.extend {
#   defaults: joint.util.deepSupplement {
#     type: 'httpdd.BlockEntry',
#     size:
#       width: gridMultiplier
#       height: gridMultiplier
#     attrs:
#       path:
#         transform: 'translate(0,0)' # 'translate(' + (-gridMultiplier) + ', ' + (-gridMultiplier) + ')'
#       text:
#         'ref-y': .5
#   }, joint.shapes.basic.Rhombus.prototype.defaults
# }

do () ->
  width = gridMultiplier * gridCellWidth
  height = gridMultiplier * gridCellHeight / 2

  joint.shapes.httpdd.StatusCode = joint.dia.Element.extend {
    markup: '<g class="rotatable"><g class="scalable"><path/></g><text class="status"/></g>'
    defaults: joint.util.deepSupplement {
      type: 'httpdd.StatusCode',
      size:
        width: width
        height: height
      attrs:
        '.':
          fill: '#FFFFFF'
          stroke: 'none'
        path:
          d: "M #{height} 0 L #{height} #{width} L 0 #{width} L 0 0 z"
          transform: 'translate(' + (-height / 2) + ', ' + (-width / 2) + ')'
          'stroke-width': 0
          fill: colorStatusCodeBlock
        '.status':
          'font-size': fontSize
          'font-weight': 'bold'
          text: ''
          'text-anchor': 'middle'
          ref: 'path'
          'y-alignment': 'middle'
          fill: colorStatusCodeText
          'font-family': fontFamily
          'ref-x': .5
          'ref-y': .5
          'ref-dy': gridMultiplier
          transform: "translate(0, 0)" # to please jointjs, and don't throw errors
    }, joint.dia.Element::defaults
  }

# GRAPH CORE

addInitial = (state) ->
  cell = new joint.shapes.fsa.StartState {
    position:
      x: state.center.x
      y: state.center.y
  }
  cells.push cell
  cell

addFinal = (state) ->
  cell = new joint.shapes.fsa.EndState {
    position:
      x: state.center.x
      y: state.center.y
  }
  cells.push cell
  cell

addDecision = (state) ->
  cell = new joint.shapes.httpdd.Decision {
    position:
      x: state.center.x
      y: state.center.y
    attrs:
      '.decision':
        text: state.name.replace /_/g, ' '
      '.coord':
        text: "#{state.center.col}#{state.center.lin}"
  }
  cells.push cell
  cell

# addBlockEntry = (state) ->
#   cell = new joint.shapes.httpdd.BlockEntry {
#     position:
#       x: state.center.x
#       y: state.center.y
#     attrs:
#       text:
#         text: '' # state.name
#   }
#   cells.push cell
#   cell

addStatusCode = (state) ->
  cell = new joint.shapes.httpdd.StatusCode {
    position:
      x: state.center.x
      y: state.center.y
    attrs:
      '.status':
        text: state.name.replace /_/g, ' '
  }
  cells.push cell
  cell

addArrow = (transition) ->
  switch transition.message
    when 'true'
      message = 'T'
      color = colorTrue
    when 'false'
      message = 'F'
      color = colorFalse
    when 'anything'
      message = ''
      color = colorAnything
  cell = new joint.shapes.fsa.Arrow {
    smooth: false
    source:
      id: transition.state.id
    target:
      id: transition.next_state.id
    attrs:
      '.connection':
        stroke: color
      '.marker-source':
        stroke: color
        fill: color
      '.marker-target':
        stroke: color
        fill: color
    # labels: [
    #   position: .5
    #   attrs:
    #     text:
    #       text: message
    #       'font-weight': 'bold'
    #       'font-size': fontSize / 2
    # ]
    vertices: transition.coords
  }
  cells.push cell
  cell

# DATA CORE

parseCoords = ({x, y}) ->
  col = x
  lin = y
  # x
  x = x.toUpperCase()
  x += x  if x.length is 1
  x = x.charCodeAt(0) + (x.charCodeAt(1) - x.charCodeAt(0))/2
  x = x - "A".charCodeAt(0) + 1
  if x > gridCellsH then gridCellsH = x + 1
  x = gridMultiplier * gridCellWidth * x
  # y
  y = parseInt y, 10
  if y > gridCellsV then gridCellsV = y + 1
  y = gridMultiplier * gridCellHeight * y
  {x, y, col, lin}

addAssignment = (name, value) ->
  vars[name] = value

addDeclaration = (type, names) ->
  declarations[type] ?= {}
  for state in names
    state = {name: state}  if typeof state is 'string'
    for coord in ['center', 'top_left', 'bottom_right']
      continue  unless state[coord]?
      state[coord] = parseCoords state[coord]
    if state.top_left? and state.bottom_right? and state.center is undefined
      state.center =
        x: (state.bottom_right.x - state.top_left.x)/2
        y: (state.bottom_right.y - state.top_left.y)/2
    declarations[type][state.name] = state

addTransition = (state, next_state, message, coords = []) ->
  coords = (parseCoords xy  for xy in coords)
  transitions["#{state}:#{message}:#{next_state}"] = {
    state
    next_state
    message
    coords
  }

# RUN

$.getJSON jsonFsmUrl, (httpdd) ->
  stmts = httpdd.statements

  for stmt in stmts
    switch stmt.__type
      when 'assignment'
        addAssignment stmt.name, stmt.value
      when 'declaration'
        addDeclaration stmt.value, stmt.names
      when 'transition'
        for state in stmt.states
          for message in stmt.messages
            addTransition state, stmt.next_state, message, stmt.coords

  declarations.decision[vars.Initial] = declarations.state[vars.Initial] = addInitial declarations.state[vars.Initial]
  declarations.decision[vars.Final] = declarations.state[vars.Final] = addFinal declarations.state[vars.Final]

  for k, v of declarations.decision
    continue  if k in [vars.Initial, vars.Final]
    declarations.decision[k] = declarations.state[k] = addDecision v

  # FIXME
  # for k, v of declarations.block_entry
  #   declarations.block_entry[k] = declarations.state[k] = addBlockEntry v

  # for k, v of declarations.status_code
  #   declarations.status_code[k] = declarations.state[k] = addStatusCode v

  for k, v of transitions
    continue  unless declarations.block_entry[v.next_state]?
    for k2, v2 of transitions
      continue  unless v2.state is v.next_state
      v.next_state = v2.next_state
      break

  for k, v of transitions
    continue  if declarations.block_entry[v.state]?

    # create multiple status code "states"
    if declarations.status_code[v.state]?
      continue  unless v.coords.length
      v.state =
        name: declarations.state[v.state].name
        center: v.coords[0]
      v.state = addStatusCode v.state
      v.coords = v.coords.slice 1, v.coords.length
    else
      v.state = declarations.state[v.state]

    # create multiple status code "states"
    if declarations.status_code[v.next_state]?
      v.next_state =
        name: declarations.state[v.next_state].name
        center: v.coords[v.coords.length-1]
      v.next_state = addStatusCode v.next_state
      v.coords = v.coords.slice 0, v.coords.length - 1
    else
      v.next_state = declarations.state[v.next_state]

    transitions[k] = addArrow v

  try render()

  # FOREWORD
  $('#to_png').on 'click', () ->
    paper.toPNG openDataUrl
  $('#to_jpeg').on 'click', () ->
    paper.toJPEG openDataUrl
  $('#to_svg').on 'click', () ->
    svg = paper.toSVG()
    dataUrl = 'data:image/svg+xml;base64,' + btoa unescape encodeURIComponent svg
    openDataUrl dataUrl

  $('#to_png').css 'display', 'none'  unless paper.toPNG
  $('#to_jpeg').css 'display', 'none'  unless paper.toJPEG
  $('#to_svg').css 'display', 'none'  unless paper.toSVG
  $('#foreword').css 'display', 'block'

#
