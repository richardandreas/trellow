import React, { useState } from "react";
import { useHistory, useLocation } from "react-router-dom";
import { Layout, Menu } from "antd";
import {
  AppstoreOutlined,
  FundProjectionScreenOutlined,
  ProjectOutlined,
  SettingOutlined,
} from "@ant-design/icons";

const Sidebar = ({ collapsed, selectedMenuItems }) => {
  const [collapsedWidth, setCollapsedWidth] = useState(true);
  const history = useHistory();
  const location = useLocation();

  return (
    <Layout.Sider
      breakpoint="lg"
      collapsed={collapsed}
      collapsedWidth={collapsedWidth ? "0" : "80"}
      collapsible
      onBreakpoint={(broken) => setCollapsedWidth(broken)}
      trigger={null}
    >
      <div style={{ height: 64 }} />
      <Menu
        onClick={({ key }) => history.push(key)}
        defaultSelectedKeys={location.pathname}
        theme="dark"
        mode="inline"
      >
        <Menu.Item key="/projects" icon={<AppstoreOutlined />}>
          Projects
        </Menu.Item>
        <Menu.Item key="/sprints" icon={<ProjectOutlined />}>
          Sprints
        </Menu.Item>
        <Menu.Item key="/statistics" icon={<FundProjectionScreenOutlined />}>
          Statistics
        </Menu.Item>
        <Menu.Item key="/settings" icon={<SettingOutlined />}>
          Settings
        </Menu.Item>
      </Menu>
    </Layout.Sider>
  );
};

export default Sidebar;
