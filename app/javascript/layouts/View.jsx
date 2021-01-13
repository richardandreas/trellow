import React from "react";
import { Layout } from "antd";

function View({ children }) {
  return <Layout.Content>{children}</Layout.Content>;
}

export default View;
