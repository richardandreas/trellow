import React from "react";
import { Layout, Result, Button } from "antd";
import { Link } from "react-router-dom";

const Error = ({ code }) => {
  const subTitles = {
    403: "Sorry, you are not authorized to access this page.",
    404: "Sorry, the page you visited does not exist.",
    500: "Sorry, something went wrong.",
  };

  return (
    <Layout.Content>
      <Result
        status={code}
        title={code}
        subTitle={subTitles[code]}
        extra={
          <Link to="/projects">
            <Button type="primary">Back Home</Button>
          </Link>
        }
      />
    </Layout.Content>
  );
};

export default Error;
