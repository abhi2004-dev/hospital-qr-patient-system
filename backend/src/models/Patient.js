// src/models/Patient.js
const mongoose = require('mongoose');

const PrescriptionSchema = new mongoose.Schema({
  doctorId: String,
  meds: [{ name: String, dose: String, duration: String }],
  notes: String,
  createdAt: { type: Date, default: Date.now }
});

const PatientSchema = new mongoose.Schema({
  // STEP 1
  email: String,
  passwordHash: String,             // if you add login later
  photoUrl: String,                 // (optional: future)

  // STEP 2 – Personal Info
  name: { type: String, required: true },
  dob: Date,
  phone: String,
  gender: String,
  bloodGroup: String,

  // STEP 3 – Guardian Info
  guardianName: String,
  guardianContact: String,
  relation: String,

  // STEP 4 – Medical Info
  allergy: String,
  medications: String,
  pastSurgery: String,
  chronicIllness: String,
  insurance: String,

  // STEP 5 – Emergency Info
  emergencyName: String,
  emergencyContact: String,
  emergencyRelation: String,

  // QR + Prescriptions
  qrId: { type: String, unique: true, index: true },
  prescriptions: [PrescriptionSchema],

  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Patient', PatientSchema);
