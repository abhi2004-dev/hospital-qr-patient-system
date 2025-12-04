// ---------------- PATIENT REGISTER (FULL DATA) ----------------
router.post('/patient/register', async (req, res) => {
  try {
    const {
      // STEP 1
      email,
      password, // optional for later hashing

      // STEP 2
      name,
      dob,
      phone,
      gender,
      bloodGroup,

      // STEP 3
      guardianName,
      guardianContact,
      relation,

      // STEP 4
      allergy,
      medications,
      pastSurgery,
      chronicIllness,
      insurance,

      // STEP 5
      emergencyName,
      emergencyContact,
      emergencyRelation
    } = req.body;

    if (!name || !phone) {
      return res.status(400).json({
        success: false,
        message: "Name & phone are required"
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
    console.error("Patient register error:", err);
    res.status(500).json({
      success: false,
      message: "Server error registering patient"
    });
  }
});
