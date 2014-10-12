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

gridMultiplier = 25 # in pixels
gridCellWidth = 10 # * gridMultiplier for pixels
gridCellHeight = 4 # * gridMultiplier for pixels
gridCellsH = 26
gridCellsV = 26
paperWidth = gridMultiplier * gridCellWidth * (gridCellsH + 2)
paperHeight = gridMultiplier * gridCellHeight * (gridCellsV + 2)

graph = new joint.dia.Graph()
paper = new joint.dia.Paper {
  el: $ '#paper'
  width: paperWidth
  height: paperHeight
  gridSize: gridMultiplier
  model: graph
  async: true
}
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

joint.shapes.httpdd.Decision = joint.shapes.basic.Rhombus.extend {
  defaults: joint.util.deepSupplement {
    type: 'httpdd.Decision',
    size:
      width: gridMultiplier * 2
      height: gridMultiplier * 2
    attrs:
      path:
        transform: 'translate(' + (-gridMultiplier) + ', ' + (-gridMultiplier) + ')'
      text:
        'ref-y': .5
  }, joint.shapes.basic.Rhombus.prototype.defaults
}

joint.shapes.httpdd.BlockEntry = joint.shapes.basic.Rhombus.extend {
  defaults: joint.util.deepSupplement {
    type: 'httpdd.BlockEntry',
    size:
      width: gridMultiplier
      height: gridMultiplier
    attrs:
      path:
        transform: 'translate(' + (-gridMultiplier) + ', ' + (-gridMultiplier) + ')'
      text:
        'ref-y': .5
  }, joint.shapes.basic.Rhombus.prototype.defaults
}

joint.shapes.httpdd.StatusCode = joint.shapes.basic.Rect.extend {
  defaults: joint.util.deepSupplement {
    type: 'httpdd.StatusCode',
    size:
      width: gridMultiplier * 10
      height: gridMultiplier * 2
    attrs:
      rect:
        transform: 'translate(' + (-gridMultiplier * 2) + ', ' + (-gridMultiplier) + ')'
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
      text:
        text: state.name.replace '_', ' '
  }
  graph.addCell cell
  cell

addBlockEntry = (state) ->
  cell = new joint.shapes.httpdd.BlockEntry {
    position:
      x: state.center.x
      y: state.center.y
    attrs:
      text:
        text: '' # state.name
  }
  graph.addCell cell
  cell

addStatusCode = (state) ->
  cell = new joint.shapes.httpdd.StatusCode {
    position:
      x: state.center.x
      y: state.center.y
    attrs:
      text:
        text: state.name.replace '_', ' '
  }
  graph.addCell cell
  cell

addArrow = (transition) ->
  switch transition.message
    when 'true' then color = '#00FF00'
    when 'false' then color = '#FF0000'
    else color = '#0000FF'
  cell = new joint.shapes.fsa.Arrow {
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
    labels: [
      position: .5
      attrs:
        text:
          text: transition.message
          stroke: color
          'font-weight': 'bold'
    ]
    vertices: transition.coords
  }
  graph.addCell cell
  cell

# DATA CORE

parseCoords = ({x, y}) ->
  # x
  x = x.toUpperCase()
  x += x  if x.length is 1
  x = x.charCodeAt(0) + (x.charCodeAt(1) - x.charCodeAt(0))/2
  x = x - "A".charCodeAt(0) + 1
  x = gridMultiplier * gridCellWidth * x
  # y
  y = parseInt y, 10
  y = gridMultiplier * gridCellHeight * y
  {x, y}

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
            message = '*'  if message is 'anything'
            addTransition state, stmt.next_state, message, stmt.coords

  declarations.decision[vars.Initial] = declarations.state[vars.Initial] = addInitial declarations.state[vars.Initial]
  declarations.decision[vars.Final] = declarations.state[vars.Final] = addFinal declarations.state[vars.Final]

  for k, v of declarations.decision
    continue  if k in [vars.Initial, vars.Final]
    declarations.decision[k] = declarations.state[k] = addDecision v

  # FIXME
  for k, v of declarations.block_entry
    declarations.block_entry[k] = declarations.state[k] = addBlockEntry v

  # for k, v of declarations.status_code
  #   declarations.status_code[k] = declarations.state[k] = addStatusCode v

  for k, v of transitions
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
