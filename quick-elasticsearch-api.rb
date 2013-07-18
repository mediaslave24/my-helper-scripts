#!/usr/bin/env ruby
# vim: syntax=ruby
require 'json'

module CurlElasticApi
  extend self
  def base_uri
    'localhost:9200'
  end

  def req(path, data=nil, mtd=nil)
    path = "#{base_uri}/#{path.strip}".squeeze('/')

    com = []
    com << "curl"
    com << "X#{mtd}" if mtd
    com << path
    com << "-d '#{data}'" if data
    com << "2> /dev/null"

    com = com.join(" ")

    res = `#{com}`
    begin
    JSON.pretty_generate JSON.parse(res)
    rescue JSON::ParserError
      res
    end
  end
end

puts(CurlElasticApi.req $*[0], $*[1], $*[2]) if __FILE__ == $0
