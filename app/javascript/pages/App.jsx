import React, { useState, useEffect } from "react";
import AppLayout from "../layouts/AppLayout";
import Project from "../views/Project";
import PageLoader from "../components/PageLoader";
import { Redirect } from "react-router-dom";
import { getUser } from "../helpers/request";

const App = () => {
  const [loading, setLoading] = useState(true);
  const [redirect, setRedirect] = useState("");

  useEffect(() => {
    // Redirect to login page if there is no session token or users session is expired
    getUser()
      .then(() => setLoading(false))
      .catch(() => setRedirect("/login"));
  });

  return (
    <>
      {redirect && <Redirect to={redirect} />}

      {loading ? (
        <PageLoader />
      ) : (
        <AppLayout selectedSidebarItems={["1"]}>
          <Project />
        </AppLayout>
      )}
    </>
  );
};

export default App;
