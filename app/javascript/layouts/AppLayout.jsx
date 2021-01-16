import React, { useState } from "react";
import { Layout } from "antd";
import { MenuUnfoldOutlined, MenuFoldOutlined } from "@ant-design/icons";
import Sidebar from "../components/Sidebar";
import Footer from "../components/Footer";

const AppLayout = ({ children, selectedSidebarItems }) => {
  const [sidebarCollapsed, setSidebarCollapsed] = useState(true);

  return (
    <Layout>
      <Sidebar
        collapsed={sidebarCollapsed}
        selectedMenuItems={selectedSidebarItems}
      />
      <Layout className="main-layout">
        <Layout.Header>
          {React.createElement(
            sidebarCollapsed ? MenuUnfoldOutlined : MenuFoldOutlined,
            {
              id: "hamburger",
              onClick: () => setSidebarCollapsed(!sidebarCollapsed),
            }
          )}

          <span id="header-logo" className="anticon">
            <img src={"/assets/logo.svg"} />
          </span>
        </Layout.Header>

        {children}
        <Footer />
      </Layout>
    </Layout>
  );
};

export default AppLayout;
