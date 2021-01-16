import React from "react";
import { Spin } from "antd";
import { LoadingOutlined } from "@ant-design/icons";

const PageLoader = () => {
  const antIcon = <LoadingOutlined spin />;

  return (
    <div className="page-loader">
      <Spin indicator={antIcon} />
    </div>
  );
};

export default PageLoader;
