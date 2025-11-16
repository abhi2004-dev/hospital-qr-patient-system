// src/routes/authRoutes.js
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Doctor = require('../models/Doctor');
const Patient = require('../models/Patient');

// register doctor (simple)
router.post('/doctor/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    if (!email || !password) return res.status(400).json({ success: false, message: 'Missing fields' });

    const existing = await Doctor.findOne({ email });
    if (existing) return res.status(400).json({ success: false, message: 'Email already used' });

    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(password, salt);

    const doc = await Doctor.create({ name, email, passwordHash });
    res.json({ success: true, body: { doctor: { id: doc._id, name: doc.name, email: doc.email } }});
  } catch (err) { res.status(500).json({ success: false, message: err.message }); }
});

// login doctor
router.post('/doctor/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const doc = await Doctor.findOne({ email });
    if (!doc) return res.status(400).json({ success: false, message: 'Invalid credentials' });

    const match = await bcrypt.compare(password, doc.passwordHash || '');
    if (!match) return res.status(400).json({ success: false, message: 'Invalid credentials' });

    const token = jwt.sign({ id: doc._id, email: doc.email }, process.env.JWT_SECRET || 'dev', { expiresIn: '7d' });
    res.json({ success: true, body: { token, doctor: { id: doc._id, name: doc.name, email: doc.email } }});
  } catch (err) { res.status(500).json({ success: false, message: err.message }); }
});

// patient register (basic)
router.post('/patient/register', async (req, res) => {
  try {
    const { name, phone } = req.body;
    if (!name) return res.status(400).json({ success: false, message: 'Missing name' });
    const qrId = `P-${Date.now().toString().slice(-6)}`;
    const p = await Patient.create({ name, phone, qrId });
    res.json({ success: true, body: { patient: p }});
  } catch (err) { res.status(500).json({ success: false, message: err.message }); }
});

module.exports = router;
