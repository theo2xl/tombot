# Description:
#   Generates commands to track days since an event
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot it's been <number> days since <event> - Set the day when the event happened
#   hubot how long since <event>? - Display the number of days since the event
#
# Author:
#   zenhob

module.exports = (robot) ->
  robot.respond /it's (\d+) days until\s+(.*?)[.?!]?$/i, (msg) ->
    date = new Date
    date.setTime((parseInt(msg.match[1])*1000*24*60*60) - date.getTime())
    date.setHours(0,0,0,0)
    robot.brain.data.days_until ||= {}
    robot.brain.data.days_until[msg.match[2]] = date
    msg.send "okay, it's " + msg.match[1] + " days until " + msg.match[2]

  robot.respond /how long until\s+(.*?)\??$/i, (msg) ->
    if robot.brain.data.days_until && robot.brain.data.days_until[msg.match[1]]
      date = robot.brain.data.days_until[msg.match[1]]
      days_until = Math.floor((new Date - new Date(date).getTime()) / (1000*24*60*60))
      msg.send "it's " + days_until + " days until " + msg.match[1]
    else
      msg.send "I don't recall that event"