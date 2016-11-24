// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket, Presence} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:1", {id: window.location.search.split('=')[1]})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

let presences = {} // client's initial empty presence state
// receive initial presence data from server, sent after join
channel.on("presence_state", state => {
  presences = Presence.syncState(presences, state)
  console.log({users: Presence.list(presences)})
})
// receive "presence_diff" from server, containing join/leave events
channel.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff)
  if (document.getElementById('list-users')) {
    displayUsers(Presence.list(presences))
  }
})

let showButton = document.getElementById("show")
if (showButton) {
  showButton.addEventListener("click", function() {
    channel.push("new_images")
  }, false)

  channel.on("question_answered", data => {
    console.log(data);
    //let { position, player, answer } = data;
    //let li = document.getElementById(data.player)
    //li.appendChild(document.createTextNode(`-${data.position}/${data.answer}`));
  })
}

let answerButtons = document.querySelectorAll(".answer")
if (answerButtons.length) {
  answerButtons.forEach(function(answerButton) {
    answerButton.addEventListener("click", function() {
      channel.push("submit_answer", {answer: this.innerText})
    }, false)
  });
}


channel.on("next_question", question => {
  setImages(question);
})

function displayUsers(presences) {
  document.getElementById('list-users').innerHTML = '';

  for (let presence of presences) {
    let li = document.createElement('li');
    li.id = presence.metas[0].id;
    li.innerText = presence.metas[0].id;
    document.getElementById('list-users').appendChild(li);

    console.log(presence.metas[0].id);
  }
}

function setImages(question) {
  let q = document.getElementById("question");
  let img_1 = document.getElementById("img_1")
  let img_2 = document.getElementById("img_2")

  q.innerText = question.question;
  if (img_1 && img_2) {
    img_1.src = question.img_1;
    img_2.src = question.img_2;
  }
}

export default socket
