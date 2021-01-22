import React, { useState, useEffect } from "react";
import LoginLayout from "../layouts/LoginLayout";
import PageLoader from "../components/PageLoader";
import { Link, Redirect } from "react-router-dom";
import { Form, Input, Button, Checkbox } from "antd";
import { UserOutlined, LockOutlined } from "@ant-design/icons";
import { getSession } from "../helpers/request";
import { authenticateUser } from "../helpers/request";
import {
  sessionTokenExists,
  destroySessionToken,
  mapErrors,
} from "../helpers/app";

const Login = () => {
  const [pageLoading, setPageLoading] = useState(sessionTokenExists());
  const [formLoading, setFormLoading] = useState(false);
  const [redirect, setRedirect] = useState("");
  const [form] = Form.useForm();

  const submit = (data) => {
    setFormLoading(true);

    authenticateUser(data)
      .then(() => setRedirect("/projects"))
      .catch((errors) => form.setFields(mapErrors(errors)))
      .finally(() => setFormLoading(false));
  };

  useEffect(() => {
    if (!pageLoading) {
      return;
    }

    // Redirect to projects page if user already has an active session
    getSession()
      .then(() => setRedirect("/projects"))
      .catch(() => {
        destroySessionToken();
        setPageLoading(false);
      });
  }, []);

  return (
    <>
      {redirect && <Redirect to={redirect} />}

      {pageLoading ? (
        <PageLoader />
      ) : (
        <LoginLayout>
          <h1>Welcome</h1>

          <Form
            name="login"
            size="large"
            className="login-form"
            form={form}
            initialValues={{ remember: true }}
            onFinish={(data) => submit(data)}
          >
            <Form.Item
              name="email"
              rules={[
                { required: true, message: "Email can't be blank" },
                { type: "email", message: "Email is invalid" },
              ]}
            >
              <Input
                prefix={<UserOutlined className="site-form-item-icon" />}
                placeholder="Email"
              />
            </Form.Item>
            <Form.Item
              name="password"
              rules={[{ required: true, message: "Password can't be blank" }]}
            >
              <Input
                prefix={<LockOutlined className="site-form-item-icon" />}
                type="password"
                placeholder="Password"
              />
            </Form.Item>
            <Form.Item>
              <Form.Item name="remember" valuePropName="checked" noStyle>
                <Checkbox>Remember me</Checkbox>
              </Form.Item>

              <a className="login-form-forgot" href="">
                Forgot password
              </a>
            </Form.Item>

            <Form.Item>
              <Button
                block
                type="primary"
                htmlType="submit"
                className="login-form-button"
                loading={formLoading}
              >
                Log in
              </Button>
            </Form.Item>
            <Form.Item>
              <Link to="/logon">
                <Button block type="default" className="login-form-button">
                  Register now
                </Button>
              </Link>
            </Form.Item>
          </Form>
        </LoginLayout>
      )}
    </>
  );
};

export default Login;
