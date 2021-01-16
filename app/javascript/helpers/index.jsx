// Declare all general heler functions in this file

// Stores the necessary headers in the Local Storage
export function setHeaders(headers) {
  if (headers["access-token"]) {
    localStorage.setItem("access-token", headers["access-token"]);
  }
}

// Provides the necessary headers for each request to the API
export function getHeaders() {
  return {
    "X-CSRF-Token": window._token,
    "access-token": localStorage.getItem("access-token"),
  };
}

// Maps Rails ActiveRecrd error hashes into Antd form field errors
export function mapErrors(requestErrors) {
  const entries = Object.entries(requestErrors);
  let formErrors = [];

  for (const [name, errors] of entries) {
    formErrors.push({
      name: name,
      errors: errors,
    });
  }

  return formErrors;
}
