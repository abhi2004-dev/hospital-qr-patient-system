import Patient from "../models/Patient.js";
import QRCode from "qrcode";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

// Register a new patient and generate QR code

export const registerPatient = async (req, res) => {
  try {
    const { name, age, gender, phone, address, medicalHistory, password } = req.body;

    // check if patient already exists
    const existing = await Patient.findOne({ phone });
    if (existing) {
      return res.status(400).json({ success: false, message: "Patient already exists" });
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    const newPatient = new Patient({
      patientId: new Date().getTime().toString(),
      name,
      age,
      gender,
      phone,
      address,
      medicalHistory,
      password: hashedPassword,
    });

    // generate QR code
    const qrData = `patient:${newPatient._id}`;
    const qrImage = await QRCode.toDataURL(qrData);
    newPatient.qrCode = qrImage;

    await newPatient.save();

    res.status(201).json({ success: true, patient: newPatient });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Patient login
export const loginPatient = async (req, res) => {
  try {
    const { phone, password } = req.body;
    const patient = await Patient.findOne({ phone });
    if (!patient) {
      return res.status(404).json({ success: false, message: "Patient not found" });
    }

    const isMatch = await bcrypt.compare(password, patient.password);
    if (!isMatch) {
      return res.status(400).json({ success: false, message: "Invalid credentials" });
    }

    const token = jwt.sign({ id: patient._id }, process.env.JWT_SECRET, { expiresIn: "1d" });

    res.status(200).json({ success: true, token, patient });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get patient info by ID (for QR scan)
export const getPatientById = async (req, res) => {
  try {
    const patient = await Patient.findById(req.params.id);
    if (!patient) {
      return res.status(404).json({ success: false, message: "Patient not found" });
    }

    res.status(200).json({ success: true, patient });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
