import React from "react";
import { Redirect } from "react-router-dom";
import { destroySession } from "../helpers/app";

const Logout = () => {
  destroySession();

  return <Redirect to="/login" />;
};

export default Logout;
