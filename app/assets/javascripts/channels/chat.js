App.chat = App.cable.subscriptions.create("ChatChannel",{

  connected: function(){
  	console.log('Disconnected from the chat channel');
  },
    # Called when the subscription is ready for use on the server

  disconnected: function() {

  },
    # Called when the subscription has been terminated by the server

  received: function(data) {
  		var messages = $('#chatbox');
  		messages.append(data['message']);
  		messages.scrollTop(messages[o].scrollHeight);
  }
    # Called when there's incoming data on the websocket for this channel
});