import React from "react";
import { Layout } from "antd";
import { Menu } from "antd";
import {
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
} from "@ant-design/icons";

function Sidebar({ collapsed }) {
  return (
    <Layout.Sider
      trigger={null}
      collapsible
      collapsed={collapsed}
      breakpoint="lg"
    >
      <div style={{ height: 64 }} />
      <Menu theme="dark" mode="inline" defaultSelectedKeys={["1"]}>
        <Menu.Item key="1" icon={<UserOutlined />}>
          nav 1
        </Menu.Item>
        <Menu.Item key="2" icon={<VideoCameraOutlined />}>
          nav 2
        </Menu.Item>
        <Menu.Item key="3" icon={<UploadOutlined />}>
          nav 3
        </Menu.Item>
        <Menu.Item key="4" icon={<UserOutlined />}>
          nav 4
        </Menu.Item>
      </Menu>
    </Layout.Sider>
  );
}

export default Sidebar;
