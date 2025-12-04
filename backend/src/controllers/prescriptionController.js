import Prescription from "../models/Prescription.js";
import Patient from "../models/Patient.js";

// Doctor adds prescription
export const addPrescriptionForPatient = async (req, res) => {
  try {
    const { patientId, doctorId, medicines, notes } = req.body;
    
    const pres = await Prescription.create({
      patient: patientId,
      doctor: doctorId,
      medicines,
      notes,
    });

    // Attach prescription ID to patient record
    await Patient.findByIdAndUpdate(patientId, {
      $push: { prescriptions: pres._id },
    });

    res.json({ success: true, prescription: pres });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
};

// Patient gets latest prescription
export const getLatestPrescriptionForPatient = async (req, res) => {
  try {
    const { patientId } = req.params;

    const latestPres = await Prescription.findOne({ patient: patientId })
      .sort({ createdAt: -1 })
      .populate("doctor patient");

    if (!latestPres) {
      return res
        .status(404)
        .json({ success: false, message: "No prescription found" });
    }

    res.json({ success: true, prescription: latestPres });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
