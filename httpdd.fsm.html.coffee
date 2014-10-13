$.ajaxSetup cache: false

stmts = []
vars = {}
declarations =
  state: {}
  status_code: {}
  decision: {}
  block: {}
  block_entry: {}
transitions = {}

gridMultiplier = 20 # in pixels
gridCellWidth = 10 # * gridMultiplier for pixels
gridCellHeight = 4 # * gridMultiplier for pixels
gridCellsH = "P".charCodeAt(0) - "A".charCodeAt(0) + 1
gridCellsV = 26
paperWidth = gridMultiplier * gridCellWidth * (gridCellsH + 1)
paperHeight = gridMultiplier * gridCellHeight * (gridCellsV + 1)

graph = new joint.dia.Graph()
paper = new joint.dia.Paper {
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
  <path d="M #{gridMultiplier} 0 L 0 0 0 #{gridMultiplier}" fill="none" stroke="#EEEEEE" stroke-width="0.5"/>
</pattern>
<pattern id="grid" width="#{gridMultiplier * 10}" height="#{gridMultiplier * 4}" patternUnits="userSpaceOnUse">
  <rect width="#{gridMultiplier * 10}" height="#{gridMultiplier * 4}" fill="url(#smallGrid)"/>
  <path d="M #{gridMultiplier * 10} 0 L 0 0 0 #{gridMultiplier * 4}" fill="none" stroke="#EEEEEE" stroke-width="1"/>
</pattern>
"""
V(paper.svg).prepend V """
<rect width="100%" height="100%" fill="url(#grid)" />
"""
# COLS,LINS
do () ->
  for i in [1..gridCellsH]
    graph.addCell new joint.shapes.basic.Text {
      position:
        x: gridMultiplier * gridCellWidth * i
        y: 0
      size:
        width: 'auto'
        height: 'auto'
      attrs:
        text:
          text: String.fromCharCode("A".charCodeAt(0) + i - 1)
          'font-size': gridMultiplier * .5
    }
    graph.addCell new joint.shapes.basic.Text {
      position:
        x: gridMultiplier * gridCellWidth * i
        y: paperHeight - gridMultiplier
      size:
        width: 'auto'
        height: 'auto'
      attrs:
        text:
          text: String.fromCharCode("A".charCodeAt(0) + i - 1)
          'font-size': gridMultiplier * .5
    }
  for i in [1..gridCellsV]
    graph.addCell new joint.shapes.basic.Text {
      position:
        x: 0
        y: gridMultiplier * gridCellHeight * i
      size:
        width: 'auto'
        height: 'auto'
      attrs:
        text:
          text: '' + i
          'font-size': gridMultiplier * .5
    }
    graph.addCell new joint.shapes.basic.Text {
      position:
        x: paperWidth - gridMultiplier
        y: gridMultiplier * gridCellHeight * i
      size:
        width: 'auto'
        height: 'auto'
      attrs:
        text:
          text: '' + i
          'font-size': gridMultiplier * .5
    }

# GRAPH OVERRIDE

joint.shapes.httpdd = {}

joint.shapes.fsa.StartState = joint.dia.Element.extend {
  markup: '<g class="rotatable"><g class="scalable"><circle/></g></g>'
  defaults: joint.util.deepSupplement {
    type: 'fsa.StartState'
    size:
      width: gridMultiplier * 2
      height: gridMultiplier * 2
    attrs:
      circle:
        transform: 'translate(0,0)' # 'translate(' + (gridMultiplier) + ', ' + (gridMultiplier) + ')'
        r: gridMultiplier
        fill: 'black'
  }, joint.dia.Element::defaults
}

joint.shapes.fsa.EndState = joint.dia.Element.extend {
  markup: '<g class="rotatable"><g class="scalable"><circle class="outer"/><circle class="inner"/></g></g>'
  defaults: joint.util.deepSupplement {
    type: 'fsa.EndState'
    size:
      width: gridMultiplier * 2
      height: gridMultiplier * 2
    attrs:
      '.outer':
        transform: 'translate(0,0)' # 'translate(' + (gridMultiplier) + ', ' + (gridMultiplier) + ')'
        r: gridMultiplier
        fill: 'white'
        stroke: 'black'
      '.inner':
        transform: 'translate(0,0)' # 'translate(' + (gridMultiplier) + ', ' + (gridMultiplier) + ')'
        r: gridMultiplier / 2
        fill: 'black'
  }, joint.dia.Element::defaults
}

joint.shapes.httpdd.Decision = joint.dia.Element.extend {
  markup: '<g class="rotatable"><g class="scalable"><path/></g><text class="decision"/><text class="coord"/></g>'
  defaults: joint.util.deepSupplement {
    type: 'httpdd.Decision',
    size:
      width: gridMultiplier * 2
      height: gridMultiplier * 2
    attrs:
      '.':
        fill: '#FFFFFF'
        stroke: 'none'
      path:
        d: 'M 30 0 L 60 30 30 60 0 30 z'
        transform: 'translate(' + (-gridMultiplier * 1.5) + ', ' + (-gridMultiplier * 1.5) + ')'
        'stroke-width': 0
        fill: '#EEEEEE'
      '.decision':
        'font-size': gridMultiplier * .5
        text: ''
        'text-anchor': 'middle'
        'ref-x': .5
        'ref-y': .1
        'ref-dy': 20
        ref: 'path'
        'y-alignment': 'middle'
        fill: 'black'
        'font-family': 'Arial, helvetica, sans-serif'
      '.coord':
        'font-size': gridMultiplier * .5
        text: ''
        'text-anchor': 'middle'
        'ref-x': .5
        'ref-y': .5
        'ref-dy': 20
        ref: 'path'
        'y-alignment': 'middle'
        fill: 'black'
        'font-family': 'Arial, helvetica, sans-serif'
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

joint.shapes.httpdd.StatusCode = joint.shapes.basic.Rect.extend {
  defaults: joint.util.deepSupplement {
    type: 'httpdd.StatusCode',
    size:
      width: gridMultiplier * 10
      height: gridMultiplier * 2
    attrs:
      rect:
        transform: 'translate(' + (-gridMultiplier * 2.5) + ', ' + (-gridMultiplier * 1.5) + ')'
        'stroke-width': 0
        fill: '#EEEEEE'
      text:
        'font-size': gridMultiplier * .5
  }, joint.shapes.basic.Rect.prototype.defaults
}

# GRAPH CORE

addInitial = (state) ->
  cell = new joint.shapes.fsa.StartState {
    position:
      x: state.center.x
      y: state.center.y
  }
  graph.addCell cell
  cell

addFinal = (state) ->
  cell = new joint.shapes.fsa.EndState {
    position:
      x: state.center.x
      y: state.center.y
  }
  graph.addCell cell
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
  graph.addCell cell
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
#   graph.addCell cell
#   cell

addStatusCode = (state) ->
  cell = new joint.shapes.httpdd.StatusCode {
    position:
      x: state.center.x
      y: state.center.y
    attrs:
      text:
        text: state.name.replace /_/g, ' '
  }
  graph.addCell cell
  cell

addArrow = (transition) ->
  switch transition.message
    when 'true'
      message = 'T'
      color = '#00FF00'
    when 'false'
      message = 'F'
      color = '#FF0000'
    when 'anything'
      message = ''
      color = '#0000FF'
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
    #       'font-size': gridMultiplier * .75
    # ]
    vertices: transition.coords
  }
  graph.addCell cell
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
  x = gridMultiplier * gridCellWidth * x
  # y
  y = parseInt(y, 10)
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

$.getJSON 'httpdd.fsm.json', (httpdd) ->
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
      # FIXME
      continue  unless v.state in ['100_CONTINUE']
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

#
