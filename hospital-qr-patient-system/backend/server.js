import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import cors from "cors";
import patientRoutes from "./src/routes/patientRoutes.js";

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use("/api/patients", patientRoutes);

// Root route
app.get("/", (req, res) => {
  res.send("Hospital QR Patient System Backend ✅");
});

// MongoDB connection
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI;

mongoose
  .connect(MONGO_URI)
  .then(() => {
    console.log("✅ MongoDB connected successfully");
    app.listen(PORT, () =>
      console.log(`🚀 Server running on http://localhost:${PORT}`)
    );
  })
  .catch((err) => {
    console.error("❌ MongoDB connection failed:", err.message);
    process.exit(1);
  });
