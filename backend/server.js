// backend/server.js
import dotenv from "dotenv";
import mongoose from "mongoose";
import app from "./src/app.js";

dotenv.config();

const PORT = process.env.PORT || 5000;
const MONGO = process.env.MONGO_URI;

mongoose
  .connect(MONGO)
  .then(() => {
    console.log("MongoDB connected");

    app.listen(PORT, "0.0.0.0", () => {
      console.log("Server running on http://0.0.0.0:" + PORT);
    });
  })
  .catch((err) => {
    console.error("Mongo error:", err);
  });
