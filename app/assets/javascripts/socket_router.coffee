
PB = window.PB ||= {}


window.global_room = NoDevent.room('global_room')
global_room.join (err) ->
  console?.log "error joining global_room", err
  
window.global_room

socket_defaults(global_room)

global_room.on "auction_list", (data) ->
  console?.log("got auction_list", data)
  PB.auctions.reset(data.auctions)

global_room.on "user_entered", (data) ->
  #TODO add to model/collection
  # bind UI to model/collection events
  console?.log("got user_entered", data)
  sv = new Sview('popups_user_entered', {user: data})
  $.mobile.activePage.append(sv.html)
  sv.html.popup({history: false})
  sv.html.popup('open')
  setTimeout ->
    sv.html.popup('close')
    sv.html.remove()
    sv.destroy()
  , 4000


window.message_popup = (text) ->
  sv = new Sview('popups_message', {message: text})
  $.mobile.activePage.append(sv.html)
  sv.html.popup({history: false})
  sv.html.popup('open')
  setTimeout ->
    sv.html.popup('close')
    sv.html.remove()
    sv.destroy()
  , 4000

global_room.on "message", message_popup

global_room.on "user_left", (data) ->
  console?.log("got user_left", data)

global_room.on "viewer_entered", (data) ->
  console?.log("got viewer_entered", data)

global_room.on "viewer_left", (data) ->
  console?.log("got viewer_left", data)

global_room.on "lot_list", (data) ->
  console?.log("got lot_list", data)
  PB.lots.reset(data.lots)


global_room.on "connect", ->
  socket.emit('list_auctions')

  $("#status").removeClass("offline").addClass("online").find("p").text "You are online and can bid."

global_room.on "disconnect", ->
  $("#connected").removeClass("on").find("strong").text "Offline"
  $("#status").removeClass("online").addClass("offline").find("p").text "You are offline. please wait..."


