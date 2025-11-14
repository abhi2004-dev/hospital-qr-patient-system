// backend/src/app.js
import express from "express";
import cors from "cors";

import authRoutes from "./routes/authRoutes.js";
import doctorRoutes from "./routes/doctorRoutes.js";
import patientRoutes from "./routes/patientRoutes.js";
import qrRoutes from "./routes/qrRoutes.js";
import otpRoutes from "./routes/otpRoutes.js";

const app = express();

app.use(cors({ origin: "*"}));
app.use(express.json());

app.get("/api/test", (req, res) => {
  res.send("API is reachable and working correctly!");
});

app.use("/api/auth", authRoutes);
app.use("/api/doctor", doctorRoutes);
app.use("/api/patient", patientRoutes);
app.use("/api/qr", qrRoutes);
app.use("/api/otp", otpRoutes);

app.use((req, res) => {
  res.status(404).json({ success: false, message: "Route not found" });
});

export default app;
