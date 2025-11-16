// src/models/Doctor.js
const mongoose = require('mongoose');

const DoctorSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  phone: String,
  hospital: String,
  specialization: [String],
  passwordHash: String,
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Doctor', DoctorSchema);
