import React from "react";
import { Layout } from "antd";

const LoginLayout = ({ children }) => {
  return (
    <Layout>
      <div className="main-login-container">
        <Layout.Content className="login-form-area">
          <div id="login-logo">
            <img src={"/assets/logo.svg"} />
          </div>

          {children}
        </Layout.Content>
      </div>
    </Layout>
  );
};

export default LoginLayout;
