import React from "react";
import { Redirect } from "react-router-dom";
import { destroySessionToken } from "../helpers/app";

const Logout = () => {
  destroySessionToken();

  return <Redirect to="/login" />;
};

export default Logout;
