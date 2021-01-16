import React, { useState } from "react";
import AppLayout from "../layouts/AppLayout";
import Project from "../views/Project";

const App = () => {
  const [sidebarCollapsed, setSidebarCollapsed] = useState(true);

  return (
    <AppLayout selectedSidebarItems={["1"]}>
      <Project />
    </AppLayout>
  );
};

export default App;
