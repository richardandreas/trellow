import React, { useState, useEffect } from "react";
import AppLayout from "../layouts/AppLayout";
import Projects from "../views/Projects";
import Sprints from "../views/Sprints";
import Statistics from "../views/Statistics";
import Settings from "../views/Settings";
import Error from "../views/Error";
import PageLoader from "../components/PageLoader";
import { Switch, Route, useHistory } from "react-router-dom";
import { getSession } from "../helpers/request";

const App = () => {
  const [loading, setLoading] = useState(true);
  const history = useHistory();

  useEffect(() => {
    // Redirect to login page if there is no session token or users session is expired
    getSession()
      .then(() => setLoading(false))
      .catch(() => history.push("/login"));
  }, []);

  return (
    <>
      {loading ? (
        <PageLoader />
      ) : (
        <AppLayout>
          <Switch>
            <Route exact path="/projects" component={Projects} />
            <Route exact path="/sprints" component={Sprints} />
            <Route exact path="/statistics" component={Statistics} />
            <Route exact path="/settings" component={Settings} />
            <Route component={() => <Error code={404} />} />
          </Switch>
        </AppLayout>
      )}
    </>
  );
};

export default App;
