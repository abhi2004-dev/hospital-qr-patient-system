import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import Doctor from "../models/Doctor.js";

// Doctor Register
export const registerDoctor = async (req, res) => {
  try {
    const { name, email, password, specialization } = req.body;
    const existing = await Doctor.findOne({ email });
    if (existing)
      return res.status(400).json({ success: false, message: "Doctor already exists" });

    const hashed = await bcrypt.hash(password, 10);
    const doctor = new Doctor({ name, email, password: hashed, specialization });
    await doctor.save();

    res.status(201).json({ success: true, message: "Doctor registered successfully" });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

// Doctor Login
export const loginDoctor = async (req, res) => {
  try {
    const { email, password } = req.body;
    const doctor = await Doctor.findOne({ email });
    if (!doctor)
      return res.status(404).json({ success: false, message: "Doctor not found" });

    const valid = await bcrypt.compare(password, doctor.password);
    if (!valid)
      return res.status(400).json({ success: false, message: "Invalid credentials" });

    const token = jwt.sign({ id: doctor._id }, process.env.JWT_SECRET || "secret", {
      expiresIn: "1d",
    });

    res.status(200).json({ success: true, token, doctor });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};
