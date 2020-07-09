import { Controller } from "stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = [ "messages", "newMessage" ]

  connect() {
    this.subscription = consumer.subscriptions.create({ channel: "MessageChannel", id: this.data.get("id") }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this)
    })
  }

  disconnect() {
    consumer.subscriptions.remove(this.subscription)
  }

  _connected() {
    this.scrollToBottom()
  }

  _disconnected() {
  }

  _received(data) {
    if (data.message) {
      this.messagesTarget.insertAdjacentHTML('beforeend', data.message)
      this.scrollToBottom()

      if (!document.hidden) {
        this.subscription.perform("touch")
      }
    }
  }

  clearMessage(event) {
    this.newMessageTarget.value = ''
  }

  scrollToBottom() {
    window.scrollTo(0,document.body.scrollHeight)
  }
}
