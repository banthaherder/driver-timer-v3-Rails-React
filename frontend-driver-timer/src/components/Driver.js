import React, { Component } from 'react';
import ActionCable from 'actioncable';

class Driver extends Component {
  constructor(props) {
    super(props);
    this.state = {
      last_message: {},
      driver: this.props.driver
    };
  }

  componentDidMount() {
    window.fetch(`/api/stores/177/drivers/4/last_message`).then(data => {
      data.json().then(last_message => {
        this.setState({ last_message })
      })
    })
    const cable = ActionCable.createConsumer('ws://localhost:3001/cable')
    this.sub = cable.subscriptions.create('DriverMessagesChannel', {
      received: this.handleReceiveNewDriverMessage
    })
  }

  handleReceiveNewDriverMessage = ({ new_driver_message }) => {
    if (new_driver_message.driver_id === this.state.driver.id ) {
      console.log(new_driver_message);
    }
    // let updated_stores = this.state.stores.concat(new_store);
    // this.setState({ stores: updated_stores })
  }

  render() {
    return (
      <div>
        <h2>{this.state.driver.name}</h2>
        <h5>{this.state.last_message.text}</h5>
      </div>
    );
  }
}

export default Driver;
