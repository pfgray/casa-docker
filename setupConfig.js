#!/bin/env node

var fs = require('fs');

var CONFIG_FILE = '/root/casa/config.json';
var ENGINE_CONFIG_FILE = '/root/casa/casa-environment/config/dev.json';
var OUTLET_CONFIG_FILE = '/root/casa/casa-admin-outlet/src/config/engine.js';
 
fs.readFile(CONFIG, 'utf8', function (err, config) {
    if (err) {
        console.log('Error: ', err); return 1;
    }

    fs.readFile(ENGINE_CONFIG_FILE, 'utf8', function (err, environment) {
        if (err) {
            console.log('Error: ', err); return 1;
        }
        environment = JSON.parse(environment);
        environment.casa-engine.settings.engine.admin.origin = config.engine.cors_value;
        fs.writeFile(ENGINE_CONFIG_FILE, JSON.stringify(environment), function(err){if(err){console.log('Error: ', err)}});
    }

    fs.readFile(ENGINE_CONFIG_FILE, 'utf8', function (err, outlet) {
        if (err) {
            console.log('Error: ', err); return 1;
        }
        outlet.replace('http://localhost:9292', config.admin_outlet.engine_url);
        fs.writeFile(ENGINE_CONFIG_FILE, outlet, function(err){if(err){console.log('Error: ', err)}});
    }

});

