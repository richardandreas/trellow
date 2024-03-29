// Declare all general application helper functions in this file

// Stores the necessary headers in the Local Storage
export const setHeaders = (headers) => {
  if (headers["access-token"]) {
    localStorage.setItem("access-token", headers["access-token"]);
  }
};

// Provides the necessary headers for each request to the API
export const getHeaders = () => {
  return {
    "X-CSRF-Token": window._token,
    "access-token": localStorage.getItem("access-token"),
  };
};

// Checks whether a session token exists or not in the local storage
export const sessionTokenExists = () => {
  return getHeaders()["access-token"] != null;
};

// Clears users session token
export const destroySessionToken = () => {
  window.localStorage.removeItem("access-token");
};

// Maps Rails ActiveRecrd error hashes into Antd form field errors
export const mapErrors = (requestErrors) => {
  const entries = Object.entries(requestErrors);
  let formErrors = [];

  for (const [name, errors] of entries) {
    formErrors.push({
      name: name,
      errors: errors,
    });
  }

  return formErrors;
};
