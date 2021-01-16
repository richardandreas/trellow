import React, { useState } from "react";
import { Layout, Menu } from "antd";
import {
  AppstoreOutlined,
  FundProjectionScreenOutlined,
  ProjectOutlined,
  SettingOutlined,
} from "@ant-design/icons";

function Sidebar({ collapsed, selectedMenuItems }) {
  const [collapsedWidth, setCollapsedWidth] = useState(true);

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
      <Menu theme="dark" mode="inline" defaultSelectedKeys={selectedMenuItems}>
        <Menu.Item key="1" icon={<AppstoreOutlined />}>
          Projects
        </Menu.Item>
        <Menu.Item key="2" icon={<ProjectOutlined />}>
          Sprints
        </Menu.Item>
        <Menu.Item key="3" icon={<FundProjectionScreenOutlined />}>
          Statistics
        </Menu.Item>
        <Menu.Item key="4" icon={<SettingOutlined />}>
          Settings
        </Menu.Item>
      </Menu>
    </Layout.Sider>
  );
}

export default Sidebar;
