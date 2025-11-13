import express from "express";
import cors from "cors";
import authRoutes from "./routes/authRoutes.js";
import doctorRoutes from "./routes/doctorRoutes.js";
import patientRoutes from "./routes/patientRoutes.js";

const app = express();

// ✅ Enable CORS so your Flutter app (on phone) can connect to backend
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

// ✅ Parse incoming JSON requests
app.use(express.json());

// ✅ Test route (optional — to verify connection in browser)
app.get("/", (req, res) => {
  res.send("Hospital QR Backend ✅ Server is running fine.");
});

// ✅ Another test route (you can open this in phone browser)
app.get("/api/test", (req, res) => {
  res.send("✅ API is reachable and working correctly!");
});

// ✅ Main routes
app.use("/api/auth", authRoutes);
app.use("/api/doctor", doctorRoutes);
app.use("/api/patient", patientRoutes);

// ✅ 404 fallback for unknown routes
app.use((req, res) => {
  res.status(404).json({ success: false, message: "Route not found" });
});

export default app;
