import dotenv from "dotenv";
dotenv.config();

import app from "./src/app.js";
import mongoose from "mongoose";

const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI;

if (!MONGO_URI) {
  console.error("MONGO_URI missing in .env");
  process.exit(1);
}

mongoose.connect(MONGO_URI)
  .then(() => {
    console.log("✅ MongoDB connected");
    app.listen(PORT, () => console.log(`🚀 Server running on http://localhost:${PORT}`));
  })
  .catch(err => {
    console.error("Mongo connection error:", err.message);
    process.exit(1);
  });
