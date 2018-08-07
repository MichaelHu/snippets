import React from 'react';
import Bundle from 'Bundle';
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';
import todoBundle from 'bundle-loader?lazy!./todo';

export default function TodoApp( props ) {
    return ( 
        <Bundle load={todoBundle}>
            { 
                ( TodoMain ) => {
                    return <TodoMain />;
                } 
            }
        </Bundle>
    );
}
