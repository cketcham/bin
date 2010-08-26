#!/usr/bin/ruby
# Cameron Ketcham
# 8-25-10

# This script is designed to tell me in what order to brush the four quadrants of my mouth.
# I think it could make a difference because the longer I brush the more sudsy (is that a good description?)
# my mouth becomes. I figure using a randomized algorithm will help prevent different quadrants from
# receiving different quality brushing.
# (If only it could help me brush my teeth on nights when I am too tired since I was up so late programming)
# It uses the built in function rand provided by ruby and a random sequence generator from RANDOM.org if
# if a network connection is available

require 'net/http'
require 'uri'

numbers = %w(First Second Third Fourth)
quadrants = ['Upper Left', 'Upper Right', 'Lower Left', 'Lower Right'].sort_by {|x| rand}

begin
    Net::HTTP.get(URI.parse('http://www.random.org/sequences/?min=0&max=3&col=1&format=plain')).each_with_index do |r, i|
        puts numbers[i] + ": " + quadrants[r.to_i]
    end
rescue StandardError, Timeout::Error
    puts "RANDOM.ORG is not working reverting to local random values"
    quadrants.each_with_index do |line, i|
        puts numbers[i] + ": " + line
    end
end

