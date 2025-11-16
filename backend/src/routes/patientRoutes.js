// src/routes/patientRoutes.js
const express = require('express');
const router = express.Router();
const Patient = require('../models/Patient');

// get patient summary by id or qrId
router.get('/summary/:id', async (req, res) => {
  try {
    const id = req.params.id;
    // allow both Mongo _id or qrId
    const patient = await Patient.findOne({ $or: [{ _id: id }, { qrId: id }] }).lean();
    if (!patient) return res.status(404).json({ success: false, message: 'Patient not found' });

    // return only emergency fields
    const summary = {
      _id: patient._id,
      name: patient.name,
      bloodGroup: patient.bloodGroup,
      allergies: patient.allergies || [],
      guardianContact: patient.guardianContact,
      lastPrescription: (patient.prescriptions || []).slice(-1)[0] || null
    };

    res.json({ success: true, body: { patient: summary } });
  } catch (err) { res.status(500).json({ success: false, message: err.message }); }
});

// add prescription
router.post('/:id/prescription', async (req, res) => {
  try {
    const id = req.params.id;
    const { doctorId, meds, notes } = req.body;
    const p = await Patient.findOne({ $or: [{ _id: id }, { qrId: id }] });
    if (!p) return res.status(404).json({ success: false, message: 'Patient not found' });

    p.prescriptions.push({ doctorId, meds, notes });
    await p.save();
    res.json({ success: true, body: { message: 'Prescription added' }});
  } catch (err) { res.status(500).json({ success: false, message: err.message }); }
});

module.exports = router;
