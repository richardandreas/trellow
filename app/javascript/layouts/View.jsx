import React from "react";
import { Layout } from "antd";

function View({ children }) {
  return (
    <Layout.Content className="main-content-area">{children}</Layout.Content>
  );
}

export default View;
