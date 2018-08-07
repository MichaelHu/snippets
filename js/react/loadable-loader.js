import Loadable from 'react-loadable';
import { BrowserRouter as Router, Route, Switch, Link } from 'react-router-dom';

const Loading = ( props ) => {
    return <div> Loading ... </div>;
};

const geometries  = [
    'basic'
    , 'lines'
    , 'text'
    , 'plane'
    , 'geometry'
    , 'texture'
    , 'sprite'
];

let loadableComponents = {};
geometries.forEach( ( item ) => {
    loadableComponents[ item ] = Loadable( {
        loader: () => import( './three/' + item + '/index' )
        , loading: Loading
        , render( loaded, props ) {
            return <div><loaded.default /></div>;
        }
    } );
} );

const WebGL = ( props ) => {
    return (
        <div>
            <Route path="/webgl/three-basic" component={loadableComponents[ 'basic' ]} />
            <Route path="/webgl/three-lines" component={loadableComponents[ 'lines' ]} />
            <Route path="/webgl/three-text" component={loadableComponents[ 'text' ]} />
            <Route path="/webgl/three-plane" component={loadableComponents[ 'plane' ]} />
            <Route path="/webgl/three-geometry" component={loadableComponents[ 'geometry' ]} />
            <Route path="/webgl/three-texture" component={loadableComponents[ 'texture' ]} />
            <Route path="/webgl/three-sprite" component={loadableComponents[ 'sprite' ]} />
        </div>
    );
};

export default WebGL;
