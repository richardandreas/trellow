import React from "react";
import { Layout } from "antd";

const View = ({ children }) => {
  return (
    <Layout.Content className="main-content-area">{children}</Layout.Content>
  );
};

export default View;
