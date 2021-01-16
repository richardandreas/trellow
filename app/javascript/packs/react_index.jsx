// Run this by adding <%= javascript_pack_tag 'react_index' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render the React application at <div id="react-root">

import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import App from "../pages/App";
import Login from "../pages/Login";
import Logon from "../pages/Logon";
import "../../assets/stylesheets/react_index.less";

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <React.StrictMode>
      <BrowserRouter>
        <Switch>
          <Route exact path="/login" component={Login} />
          <Route exact path="/logon" component={Logon} />
          <Route component={App} />
        </Switch>
      </BrowserRouter>
    </React.StrictMode>,
    document.getElementById("react-root")
  );
});
