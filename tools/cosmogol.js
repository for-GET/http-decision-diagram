#!/usr/bin/env node
// Compile this repo's Cosmogol dialect -> the JSON AST (httpdd.fsm.json).
// Kotlin-free, dependency-free, and only as complete as the dialect here:
// header assignments, `from:msg -col,row-> to;` navigation lines, and
// grouped declarations (message/state/decision/status_code/block_entry/block).
// Regenerate with: node tools/cosmogol.js httpdd.fsm.cosmogol httpdd.fsm.json
'use strict';

const fs = require('fs');

function compile(text) {
  text = text.replace(/\r\n/g, '\n');
  const statements = [];

  // Header assignments: Key = "value";
  let rest = text;
  const keyRe = /^(Title|Version|Description|Initial|Final) = "([^"]*)"|(Title|Version|Description|Initial|Final) = ([A-Za-z0-9_]+);?;?$/;
  while (true) {
    const line = rest.split('\n', 1)[0];
    const m = keyRe.exec(line.trim());
    if (!m) break;
    const name = m[1] || m[3];
    const value = m[2] !== undefined ? m[2] : m[4];
    statements.push({ __type: 'assignment', name: name, value: value });
    rest = rest.slice(line.length + 1);
  }

  // Split the remainder into blank-line-separated blocks.
  const blocks = rest
    .split(/\n[ \t]*\n+/)
    .map((b) => b.replace(/\n$/, '').trim())
    .filter(Boolean);

  for (const block of blocks) {
    const lines = block.split('\n').filter((l) => l.trim() !== '');

    // Navigation line(s): from:msg[,msg] [ -coord[,coord]-> ] to;
    const navRe = /^([A-Za-z0-9_]+):\s*((?:anything|true|false)(?:\s*,\s*(?:anything|true|false))*)\s*(?:-\s*([A-Za-z0-9,]*)\s*)?->\s*([A-Za-z0-9_]+);$/;
    const navLines = lines.filter((l) => navRe.test(l.trim()));
    if (navLines.length === lines.length) {
      for (const raw of lines) {
        const m = raw.trim().match(navRe);
        const messages = m[2].split(/\s*,\s*/);
        const tr = {
          __type: 'transition',
          states: [m[1]],
          messages: messages
        };
        if (m[3]) tr.coords = m[3].split(',').map((tok) => {
          const t = tok.match(/^([A-Z]+)(\d+)$/);
          if (!t) throw new Error('bad coord token: ' + tok);
          return { x: t[1], y: t[2] };
        });
        tr.next_state = m[4];
        statements.push(tr);
      }
      continue;
    }

    // Declaration block: comma-separated names (with optional coords),
    // terminated by `: kind;`.
    if (!lines[lines.length - 1].includes(':')) {
      throw new Error('unrecognized block:\n' + block);
    }
    const kind = lines[lines.length - 1].split(':')[1].trim().replace(/;$/, '');
    if (!['message', 'state', 'decision', 'status_code', 'block_entry', 'block'].includes(kind)) {
      throw new Error('unknown declaration kind: ' + kind);
    }
    const names = [];
    for (const line of lines.slice(0, lines.length - 1)) {
      for (const item of line.trim().replace(/,$/, '').split(/\s*,\s*/)) {
        if (!item) continue;
        if (kind === 'block') {
          const mm = item.match(/^([A-Za-z0-9_]+):([A-Z]+)(\d+):([A-Z]+)(\d+)$/);
          if (mm) {
            names.push({
              name: mm[1],
              top_left: { x: mm[2], y: mm[3] },
              bottom_right: { x: mm[4], y: mm[5] }
            });
          } else if (/^[A-Za-z0-9_]+$/.test(item)) {
            names.push(item);
          } else {
            throw new Error('bad block item: ' + item);
          }
        } else {
          const m = item.match(/^([A-Za-z0-9_]+)(?::([A-Z]+)(\d+))?$/);
          if (!m) throw new Error('bad declaration item: ' + item);
          names.push(
            m[2]
              ? { name: m[1], center: { x: m[2], y: m[3] } }
              : m[1]
          );
        }
      }
    }
    statements.push({ __type: 'declaration', names: names, value: kind });
  }

  return { __type: 'state_machine', statements: statements };
}

function main() {
  const [src, dst] = process.argv.slice(2);
  if (!src || !dst) {
    console.error('usage: node tools/cosmogol.js <file.cosmogol> <file.json>');
    process.exit(2);
  }
  const out = JSON.stringify(compile(fs.readFileSync(src, 'utf8')), null, 2) + '\n';
  fs.writeFileSync(dst, out);
}

main();
