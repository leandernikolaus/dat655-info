// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// A minimal state machine, modeling a simple order lifecycle.
contract StateMachineDemo {
    enum State { Created, Paid, Shipped, Completed, Cancelled }

    State public state = State.Created;

    event StateChanged(State from, State to);

    modifier inState(State expected) {
        require(state == expected, "Invalid action for current state");
        _;
    }

    function pay() external inState(State.Created) {
        _transition(State.Paid);
    }

    function ship() external inState(State.Paid) {
        _transition(State.Shipped);
    }

    function complete() external inState(State.Shipped) {
        _transition(State.Completed);
    }

    function cancel() external inState(State.Created) {
        _transition(State.Cancelled);
    }

    function _transition(State next) private {
        emit StateChanged(state, next);
        state = next;
    }
}
