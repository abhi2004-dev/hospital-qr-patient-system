const express = require("express");
const router = express.Router();
const Patient = require("../models/Patient");

// ==================================================
//  GET FULL PATIENT PROFILE  (NEW + IMPORTANT)
// ==================================================
router.get("/:id", async (req, res) => {
  try {
    const id = req.params.id;

    const patient = await Patient.findById(id).lean();
    if (!patient) {
      return res
        .status(404)
        .json({ success: false, message: "Patient not found" });
    }

    return res.json({
      success: true,
      patient: patient,
    });
  } catch (err) {
    console.error("❌ Patient fetch error:", err.message);
    res
      .status(500)
      .json({ success: false, message: "Server error while fetching patient" });
  }
});

// ==================================================
//  GET PATIENT SUMMARY (ALREADY EXISTED)
// ==================================================
router.get("/summary/:id", async (req, res) => {
  try {
    const id = req.params.id;

    const patient = await Patient.findById(id).lean();
    if (!patient) {
      return res
        .status(404)
        .json({ success: false, message: "Patient not found" });
    }

    return res.json({
      success: true,
      body: {
        _id: patient._id,
        name: patient.name,
        bloodGroup: patient.bloodGroup,
        allergies: patient.allergies,
        guardianContact: patient.guardianContact,
        lastPrescription: patient.lastPrescription || null,
      },
    });
  } catch (err) {
    console.error("❌ Summary fetch error:", err.message);
    res
      .status(500)
      .json({ success: false, message: "Server error while fetching summary" });
  }
});

module.exports = router;
