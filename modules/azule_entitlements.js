#!/usr/bin/env node

const fs = require('fs');
const plist = require('plist');
const args = process.argv.slice(2);

try {
  const data = fs.readFileSync(args[0], 'utf8');
  var json = plist.parse(data);
  for (let [i, val] of json['com.apple.security.application-groups'].entries()) {
    if (val.split('.').length > 4) {
      delete json['com.apple.security.application-groups'][i];
    }
  }
  fs.writeFileSync(args[0], plist.build(json));
}
catch {}

