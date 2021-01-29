import React, { useState } from "react";
import LoginLayout from "../layouts/LoginLayout";
import { useHistoory, Link } from "react-router-dom";
import { Form, Input, Button, Tooltip, message } from "antd";
import {
  UserOutlined,
  LockOutlined,
  MailOutlined,
  QuestionCircleOutlined,
} from "@ant-design/icons";
import { createUser } from "../helpers/request";
import { mapErrors } from "../helpers/app";

const Logon = () => {
  const [formLoading, setFormLoading] = useState(false);
  const [form] = Form.useForm();
  const history = useHistory();

  const submit = (data) => {
    setFormLoading(true);

    createUser(data)
      .then(() => {
        message.success("An confirmation email has been sent to you!");
        history.push("/login");
      })
      .catch((errors) => form.setFields(mapErrors(errors)))
      .finally(() => setFormLoading(false));
  };

  return (
    <LoginLayout>
      <h1>Sign Up</h1>
      <p>
        Creating an account on Trellow is super easy, fast and completely free!
      </p>

      <Form
        name="login"
        size="large"
        className="logon-form"
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
            prefix={<MailOutlined className="site-form-item-icon" />}
            placeholder="Email"
          />
        </Form.Item>
        <Form.Item
          name="username"
          rules={[{ required: true, message: "Username can't be blank" }]}
        >
          <Input
            prefix={<UserOutlined className="site-form-item-icon" />}
            placeholder="Username"
            suffix={
              <Tooltip title="This name will be displayed for other users to recognize you">
                <QuestionCircleOutlined />
              </Tooltip>
            }
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
        <Form.Item
          name="password_confirmation"
          rules={[{ required: true, message: "Password can't be blank" }]}
        >
          <Input
            prefix={<LockOutlined className="site-form-item-icon" />}
            type="password"
            placeholder="Confirm password"
          />
        </Form.Item>

        <Form.Item>
          <Button
            block
            type="primary"
            htmlType="submit"
            className="login-form-button"
            loading={formLoading}
          >
            Send confirmation email
          </Button>
        </Form.Item>
        <Form.Item>
          <Link to="/login">
            <Button block type="default" className="login-form-button">
              Back to login
            </Button>
          </Link>
        </Form.Item>
      </Form>
    </LoginLayout>
  );
};

export default Logon;
