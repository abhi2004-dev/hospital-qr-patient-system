import Doctor from "../models/Doctor.js";
import Patient from "../models/Patient.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

// Doctor register
export const registerDoctor = async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!email || !password) return res.status(400).json({ success:false, message: "email/password required" });
    const existing = await Doctor.findOne({ email });
    if (existing) return res.status(400).json({ success:false, message: "Doctor exists" });
    const hashed = await bcrypt.hash(password, 10);
    const doc = await Doctor.create({ name, email, password: hashed });
    res.json({ success:true, doctor: doc });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};

// Doctor login
export const loginDoctor = async (req, res) => {
  try {
    const { email, password } = req.body;
    const doc = await Doctor.findOne({ email });
    if (!doc) return res.status(404).json({ success:false, message: "Not found" });
    const ok = await bcrypt.compare(password, doc.password);
    if (!ok) return res.status(400).json({ success:false, message: "Invalid cred" });
    const token = jwt.sign({ id: doc._id, role: "doctor" }, process.env.JWT_SECRET || "secret", { expiresIn: "1d" });
    res.json({ success:true, token, doctor: doc });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};

// Patient register
export const registerPatient = async (req, res) => {
  try {
    const { name, phone } = req.body;
    const patient = await Patient.create({ patientId: Date.now().toString(), name, phone });
    res.json({ success:true, patient });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};

// Patient login (simple)
export const loginPatient = async (req, res) => {
  try {
    const { phone } = req.body;
    const patient = await Patient.findOne({ phone });
    if (!patient) return res.status(404).json({ success:false, message: "Not found" });
    res.json({ success:true, patient });
  } catch (err) { res.status(500).json({ success:false, message: err.message }); }
};
