import React, { useEffect } from "react";
import PageLoader from "../components/PageLoader";
import { message } from "antd";
import { Redirect } from "react-router-dom";
import { useApiV1Data } from "../helpers/hooks";

const Logout = () => {
  const [data, pageLoading] = useApiV1Data();

  useEffect(() => {
    if (data != null) {
      window.tete = data;
      message.success("Your account has been successfully activated!");
    }
  }, [data]);

  return <>{pageLoading ? <PageLoader /> : <Redirect to="/login" />}</>;
};

export default Logout;
