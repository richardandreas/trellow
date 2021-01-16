import React, { useState, useEffect } from "react";
import LoginLayout from "../layouts/LoginLayout";
import axios from "axios";
import { getHeaders, mapErrors } from "../helpers";
import { Form, Input, Button, Checkbox } from "antd";
import { UserOutlined, LockOutlined } from "@ant-design/icons";

function Login() {
  const [loading, setLoading] = useState(false);
  const [form] = Form.useForm();

  const submit = (data) => {
    setLoading(true);

    axios
      .post(`/api/v1/auth`, data, { headers: getHeaders() })
      .then((response) => {
        console.log(response);
      })
      .catch((error) => {
        if (error.response) {
          form.setFields(mapErrors(error.response.data["errors"]));
        }
      })
      .finally(() => setLoading(false));
  };

  return (
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
            loading={loading}
          >
            Log in
          </Button>
        </Form.Item>
        <Form.Item>
          <Button block type="default" className="login-form-button">
            Register now
          </Button>
        </Form.Item>
      </Form>
    </LoginLayout>
  );
}

export default Login;
