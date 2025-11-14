// backend/src/routes/otpRoutes.js
import express from "express";
import { generateOtp, sendOtpEmail } from "../utils/sendOTP.js";
import OTP from "../models/OTP.js";
import Patient from "../models/Patient.js";

const router = express.Router();

// Request OTP
router.post("/request", async (req, res) => {
  try {
    const { patientId, doctorId } = req.body;

    const otp = generateOtp();
    const expireAt = new Date(Date.now() + 5 * 60 * 1000);

    await OTP.create({ patientId, doctorId, code: otp, expireAt });

    const patient = await Patient.findById(patientId);
    if (!patient) return res.json({ success: false, message: "Patient not found" });

    await sendOtpEmail(patient.email, otp);

    res.json({ success: true, message: "OTP sent" });
  } catch (e) {
    res.json({ success: false, message: "OTP request failed" });
  }
});

// Verify OTP
router.post("/verify", async (req, res) => {
  try {
    const { patientId, doctorId, code } = req.body;

    const doc = await OTP.findOne({ patientId, doctorId, code, used: false });
    if (!doc) return res.json({ success: false, message: "Invalid OTP" });

    if (doc.expireAt < Date.now())
      return res.json({ success: false, message: "OTP expired" });

    doc.used = true;
    await doc.save();

    res.json({ success: true, message: "OTP verified" });
  } catch (e) {
    res.json({ success: false, message: "OTP verification failed" });
  }
});

export default router;
