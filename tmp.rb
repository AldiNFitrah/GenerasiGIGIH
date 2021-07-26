# require 'sinatra'
require 'erb'
require 'ap'

arr = [1,2, 3]

vals = arr.map{|val| "(#{val}, #{val*val})"}
# puts(vals.join(", "))
puts("".nil?)