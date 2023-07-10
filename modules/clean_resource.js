#!/usr/bin/env node

const fs = require('fs');
const plist = require('plist');
const args = process.argv.slice(2);

try {
  const data = fs.readFileSync(args[0], 'utf8');
  var json = plist.parse(data);
  try {
    for (let x in json) {
      for (let [i, y] of json[x].entries()) {
        if (y.includes('PlugIns')){
          delete json[x][i];
        }
      }
    }
  }
  catch {
    for (let x in json) {
      for (let y in json[x]) {
        if (y.includes('PlugIns') || y.includes('WatchApp.app')){
          delete json[x][y];
        }
      }
    }
  }

  fs.writeFileSync(args[0], plist.build(json));
}
catch {}

