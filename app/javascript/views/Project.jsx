import React from "react";
import View from "../layouts/View";
import { Row, Col, Card, Skeleton } from "antd";
import { useLocation, Link } from "react-router-dom";
import { useApiV1Data } from "../helpers/hooks";

const Project = () => {
  const [data, pageLoading] = useApiV1Data();
  const location = useLocation();

  return (
    <View>
      <Row gutter={[16, 16]}>
        {pageLoading
          ? [...Array(6)].map(() => {
              return (
                <Col xs={24} sm={24} md={12} lg={8} xl={6}>
                  <Card>
                    <Skeleton active />
                  </Card>
                </Col>
              );
            })
          : data.map((project) => {
              return (
                <Col xs={24} sm={24} md={12} lg={8} xl={6}>
                  <Link to={`${location.pathname}/${project.id}`}>
                    <Card className="project-card">
                      <h3>{project.name}</h3>
                      <p>{project.description}</p>
                    </Card>
                  </Link>
                </Col>
              );
            })}
      </Row>
    </View>
  );
};

export default Project;
