// Declare all custom hooks in this file

import { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { makeRequest } from "../helpers/request";

// Returns data from the API V1, requested at the same path as tha page calling this hook
export const useApiV1Data = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const location = useLocation();

  useEffect(() => {
    makeRequest("get", `/api/v1${location.pathname}`)
      .then((response) => setData(response.data))
      .finally(() => setLoading(false));
  }, [location]);

  return [data, loading];
};
