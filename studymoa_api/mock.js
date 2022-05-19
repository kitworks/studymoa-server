#!/usr/bin/env node
const http = require('http');
const mockserver = require('mockserver');

const argv = require('yargs').argv;
const portAPI = 4000;
const directory = argv.dir || 'mocks';

console.log("argv", argv)