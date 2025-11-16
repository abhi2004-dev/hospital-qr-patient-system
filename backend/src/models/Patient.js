// src/models/Patient.js
const mongoose = require('mongoose');

const PrescriptionSchema = new mongoose.Schema({
  doctorId: String,
  meds: [{ name: String, dose: String, duration: String }],
  notes: String,
  createdAt: { type: Date, default: Date.now }
});

const PatientSchema = new mongoose.Schema({
  name: { type: String, required: true },
  phone: String,
  email: String,
  dob: Date,
  bloodGroup: String,
  allergies: [String],
  guardianContact: String,
  qrId: { type: String, unique: true, index: true }, // stored QR id
  prescriptions: [PrescriptionSchema],
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Patient', PatientSchema);
