// Declare all API request functions in this file

import axios from "axios";
import { message } from "antd";
import { getHeaders, setHeaders } from "../helpers/app";

// Get user data or check if session is active
export const getSession = () => {
  return new Promise((resolve, reject) => {
    makeRequest("get", "/api/v1/auth", null, true)
      .then((response) => resolve(response))
      .catch((error) => reject(error));
  });
};

// Authenticate user
//
// Paramerets
//   email:    String
//   password: String
//
export const authenticateUser = (data) => {
  return new Promise((resolve, reject) => {
    makeRequest("post", "/api/v1/auth", data)
      .then((response) => resolve(response))
      .catch((error) => reject(error));
  });
};

// Create user
//
// Paramerets
//   email:                 String
//   password:              String
//   password_confirmation: String
//
export const createUser = (data) => {
  return new Promise((resolve, reject) => {
    makeRequest("post", "/api/v1/users", data)
      .then((response) => resolve(response))
      .catch((error) => reject(error));
  });
};

// General request method
export const makeRequest = (method, url, data, skipMessage = false) => {
  return new Promise((resolve, reject) => {
    axios({
      method: method,
      url: url,
      headers: getHeaders(),
      data: data,
    })
      .then((response) => {
        setHeaders(response.headers);
        resolve(response);
      })
      .catch((error) => {
        if (error.response && error.response.data["errors"]) {
          return reject(error.response.data["errors"]);
        }

        if (!skipMessage) {
          message.error("Ops! There was an error");
        }

        reject({});
      });
  });
};
