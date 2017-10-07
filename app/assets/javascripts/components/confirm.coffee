################################################
################################################
##   _____              __ _                  ##
##  /  __ \            / _(_)                 ##
##  | /  \/ ___  _ __ | |_ _ _ __ _ __ ___    ##
##  | |    / _ \| '_ \|  _| | '__| '_ ` _ \   ##
##  | \__/\ (_) | | | | | | | |  | | | | | |  ##
##   \____/\___/|_| |_|_| |_|_|  |_| |_| |_|  ##
##                                            ##
################################################
################################################

$.rails.allowAction = (element) ->
  message = element.data("confirm")
  answer = false
  return true  unless message
  if $.rails.fire(element, "confirm")
    myCustomConfirmBox element, message, ->
      callback = $.rails.fire(element, "confirm:complete", [answer])
      if callback
        oldAllowAction = $.rails.allowAction
        $.rails.allowAction = ->
          true

        element.trigger "click"
        $.rails.allowAction = oldAllowAction
      return

  false

##################################################

#Function
###############
myCustomConfirmBox = (link, message, callback) ->

  #Create
  conf =
    Modal
      close:    "cancel"
      title:    message
      overlay:  0.8

  #Confirm
  ###############
  $(document).on "click", "#confirm", ->
    callback link
    Modal.destroy()

################################################
################################################
