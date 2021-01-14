import React, { useState } from "react";
import { Layout } from "antd";
import { MenuUnfoldOutlined, MenuFoldOutlined } from "@ant-design/icons";
import Sidebar from "./Sidebar";
import Footer from "./Footer";
import ProjectView from "../views/ProjectView";

const App = () => {
  const [sidebarCollapsed, setSidebarCollapsed] = useState(true);

  return (
    <Layout>
      <Sidebar collapsed={sidebarCollapsed} />
      <Layout className="main-layout">
        <Layout.Header>
          {React.createElement(
            sidebarCollapsed ? MenuUnfoldOutlined : MenuFoldOutlined,
            {
              id: "hamburger",
              onClick: () => setSidebarCollapsed(!sidebarCollapsed),
            }
          )}

          <span id="logo" className="anticon">
            <img src={"/assets/logo.svg"} />
          </span>
        </Layout.Header>
        <ProjectView />
        <Footer />
      </Layout>
    </Layout>
  );
};

export default App;
