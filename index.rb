#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)

require 'sinatra'
require 'bcrypt'
require 'json'
require 'config/db/database'
require 'config/helpers'
require 'routes'
