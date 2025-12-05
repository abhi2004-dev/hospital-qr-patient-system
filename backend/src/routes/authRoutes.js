// BACKEND: src/routes/authRoutes.js
const express = require('express');
const router = express.Router();

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Doctor = require('../models/Doctor');
const Patient = require('../models/Patient');

// ---------------- DOCTOR REGISTER ----------------
router.post('/doctor/register', async (req, res) => {
  try {
    const { name, email, password, phone, hospital, specialization } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({
        success: false,
        message: 'Name, email & password are required'
      });
    }

    const exists = await Doctor.findOne({ email });
    if (exists) {
      return res.status(400).json({
        success: false,
        message: 'Email already used'
      });
    }

    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(password, salt);

    const doctor = await Doctor.create({
      name,
      email,
      phone,
      hospital,
      specialization,
      passwordHash
    });

    return res.json({
      success: true,
      body: {
        doctor: {
          id: doctor._id,
          name: doctor.name,
          email: doctor.email,
          specialization: doctor.specialization
        }
      }
    });
  } catch (err) {
    console.error('Doctor register error:', err);
    return res.status(500).json({
      success: false,
      message: 'Server error registering doctor'
    });
  }
});

// ---------------- DOCTOR LOGIN ----------------
router.post('/doctor/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const doctor = await Doctor.findOne({ email });
    if (!doctor) {
      return res.status(400).json({ success: false, message: 'Invalid credentials' });
    }

    const match = await bcrypt.compare(password, doctor.passwordHash || '');
    if (!match) {
      return res.status(400).json({ success: false, message: 'Invalid credentials' });
    }

    const token = jwt.sign(
      { id: doctor._id, email: doctor.email },
      process.env.JWT_SECRET || 'dev',
      { expiresIn: '7d' }
    );

    return res.json({
      success: true,
      body: {
        token,
        doctor: {
          id: doctor._id,
          name: doctor.name,
          email: doctor.email,
          specialization: doctor.specialization
        }
      }
    });
  } catch (err) {
    console.error('Doctor login error:', err);
    return res.status(500).json({
      success: false,
      message: 'Server error logging in doctor'
    });
  }
});

// ---------------- PATIENT REGISTER (FULL 5-STEP DATA) ----------------
router.post('/patient/register', async (req, res) => {
  try {
    const {
      email,
      password,

      name,
      dob,
      phone,
      gender,
      bloodGroup,

      guardianName,
      guardianContact,
      relation,

      allergy,
      medications,
      pastSurgery,
      chronicIllness,
      insurance,

      emergencyName,
      emergencyContact,
      emergencyRelation
    } = req.body;

    if (!name || !phone) {
      return res.status(400).json({
        success: false,
        message: 'Name & phone are required'
      });
    }

    const qrId = `P-${Date.now().toString().slice(-6)}`;

    const patient = await Patient.create({
      email,
      name,
      dob: dob ? new Date(dob) : null,
      phone,
      gender,
      bloodGroup,

      guardianName,
      guardianContact,
      relation,

      allergy,
      medications,
      pastSurgery,
      chronicIllness,
      insurance,

      emergencyName,
      emergencyContact,
      emergencyRelation,

      qrId
    });

    return res.json({ success: true, patient });
  } catch (err) {
    console.error('Patient register error:', err);
    res.status(500).json({
      success: false,
      message: 'Server error registering patient'
    });
  }
});

module.exports = router;
