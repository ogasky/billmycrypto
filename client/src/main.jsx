import React from "react";
import ReactDOM from "react-dom/client"; // ✅ Use 'react-dom/client'
import App from "./App";
import "./index.css";

import { TransactionProvider } from './context/TransactionContext';

const root = ReactDOM.createRoot(document.getElementById("root")); // ✅ Correct way in React 18+
root.render(
  <TransactionProvider>
  <React.StrictMode>
    <App />
  </React.StrictMode>
  </TransactionProvider>,
);

